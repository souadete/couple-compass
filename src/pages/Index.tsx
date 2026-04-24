import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import { z } from "zod";
import { Clock, ShieldCheck, Link2, Download } from "lucide-react";
import { WhatsAppIcon, FacebookIcon, LinkedInIcon } from "@/components/ShareIcons";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { useToast } from "@/hooks/use-toast";
import { copy } from "@/lib/i18n";
import { QUESTIONS, type Choice } from "@/data/questions";
import { ARCHETYPES, type ArchetypeId } from "@/data/archetypes";
import { computeScore } from "@/lib/scoring";
import { shuffleArray } from "@/lib/shuffle";
import { ARCHETYPE_IMAGES } from "@/data/archetype-images";
import HeroVisual from "@/components/ambiance/HeroVisual";
import GoldFrame from "@/components/ambiance/GoldFrame";
import azwajLogo from "@/assets/azwaj-logo.png";

type Step = "intro" | "quiz" | "capture" | "result";

const captureSchema = z.object({
  firstName: z
    .string()
    .trim()
    .min(1, "Prénom requis")
    .max(80, "Prénom trop long"),
  email: z
    .string()
    .trim()
    .email("Email invalide")
    .max(255, "Email trop long"),
  consent: z
    .boolean()
    .refine((v) => v === true, "Consentement requis pour continuer"),
});

const Index = () => {
  const { toast } = useToast();
  const [step, setStep] = useState<Step>("intro");
  const [qIndex, setQIndex] = useState(0);
  const [answers, setAnswers] = useState<(Choice | null)[]>(
    () => Array.from({ length: QUESTIONS.length }, () => null),
  );
  const [firstName, setFirstName] = useState("");
  const [email, setEmail] = useState("");
  const [consent, setConsent] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [winner, setWinner] = useState<ArchetypeId | null>(null);
  const [errors, setErrors] = useState<Record<string, string>>({});

  // Scroll to top on step change
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: "smooth" });
  }, [step, qIndex]);

  const progress = useMemo(
    () => Math.round(((qIndex + (answers[qIndex] ? 1 : 0)) / QUESTIONS.length) * 100),
    [qIndex, answers],
  );

  // Shuffle options per question ONCE per session, stable across navigations.
  // Scoring is unaffected because it uses opt.key (A/B/C/D tied to score).
  const shuffledQuestions = useMemo(
    () =>
      QUESTIONS.map((q) => ({
        ...q,
        options: shuffleArray(q.options),
      })),
    [],
  );

  const handleAnswer = (choice: Choice) => {
    const next = [...answers];
    next[qIndex] = choice;
    setAnswers(next);
    // small delay for UX
    setTimeout(() => {
      if (qIndex < QUESTIONS.length - 1) {
        setQIndex(qIndex + 1);
      } else {
        setStep("capture");
      }
    }, 220);
  };

  const handleBack = () => {
    if (qIndex > 0) setQIndex(qIndex - 1);
    else setStep("intro");
  };

  const handleSubmit = async () => {
    const parsed = captureSchema.safeParse({ firstName, email, consent });
    if (!parsed.success) {
      const fe: Record<string, string> = {};
      for (const issue of parsed.error.issues) {
        fe[issue.path[0] as string] = issue.message;
      }
      setErrors(fe);
      return;
    }
    setErrors({});
    setSubmitting(true);

    try {
      const finalAnswers = answers as Choice[];
      const result = computeScore(finalAnswers);

      const { data: submissionId, error } = await supabase.rpc("submit_quiz", {
        p_first_name: parsed.data.firstName,
        p_email: parsed.data.email,
        p_consent_given: true,
        p_answers: finalAnswers,
        p_archetype: result.winner,
        p_scores: result.scores,
        p_percentages: result.percentages,
        p_language: "fr",
        p_user_agent: navigator.userAgent.slice(0, 500),
        p_referrer: document.referrer.slice(0, 500) || null,
      });

      if (error) throw error;

      const data = { id: submissionId as string };

      // Forward to n8n (await so PDF/email pipeline starts before result screen).
      // We do not block the result on a webhook error — n8n can be retried later.
      try {
        await supabase.functions.invoke("forward-to-n8n", {
          body: { submission_id: data.id },
        });
      } catch (whErr) {
        console.warn("webhook forward failed (non-blocking)", whErr);
      }

      setWinner(result.winner);
      setStep("result");
    } catch (e) {
      console.error(e);
      toast({
        title: "Une erreur est survenue",
        description: "Réessayez dans un instant.",
        variant: "destructive",
      });
    } finally {
      setSubmitting(false);
    }
  };

  const restart = () => {
    setStep("intro");
    setQIndex(0);
    setAnswers(Array.from({ length: QUESTIONS.length }, () => null));
    setFirstName("");
    setEmail("");
    setConsent(false);
    setWinner(null);
  };

  return (
    <div className="relative z-10 min-h-screen">
      <header className="container max-w-3xl py-6 flex items-center justify-between">
        <button
          onClick={restart}
          className="flex items-center gap-3 transition hover:opacity-80"
          aria-label={`${copy.appName} — ${copy.tagline}`}
        >
          <img
            src={azwajLogo}
            alt="Azwaj"
            width={220}
            height={44}
            className="h-11 w-auto"
          />
          <span className="hidden sm:inline text-xs uppercase tracking-widest text-muted-foreground font-sans">
            {copy.tagline}
          </span>
        </button>
        <Link
          to="/confidentialite"
          className="text-xs text-muted-foreground hover:text-foreground transition"
        >
          {copy.footer.privacy}
        </Link>
      </header>

      <main className="container max-w-3xl pb-20">
        {step === "intro" && <IntroScreen onStart={() => setStep("quiz")} />}

        {step === "quiz" && (
          <QuizScreen
            question={shuffledQuestions[qIndex]}
            qIndex={qIndex}
            total={QUESTIONS.length}
            progress={progress}
            currentAnswer={answers[qIndex]}
            onAnswer={handleAnswer}
            onBack={handleBack}
          />
        )}

        {step === "capture" && (
          <CaptureScreen
            firstName={firstName}
            email={email}
            consent={consent}
            errors={errors}
            submitting={submitting}
            setFirstName={setFirstName}
            setEmail={setEmail}
            setConsent={setConsent}
            onSubmit={handleSubmit}
          />
        )}

        {step === "result" && winner && (
          <ResultScreen archetype={winner} firstName={firstName} onRestart={restart} />
        )}
      </main>

      <footer className="border-t border-border/60 py-6">
        <div className="container max-w-3xl flex items-center justify-between text-xs text-muted-foreground">
          <span>{copy.footer.by}</span>
          <Link to="/confidentialite" className="hover:text-foreground transition">
            {copy.footer.privacy}
          </Link>
        </div>
      </footer>
    </div>
  );
};

/* ---------- Intro ---------- */

const IntroScreen = ({ onStart }: { onStart: () => void }) => (
  <section className="pt-4 md:pt-10 animate-in fade-in duration-500">
    {/* Hero visual — silhouettes + golden halo */}
    <div className="flex justify-center mb-6 md:mb-8">
      <HeroVisual className="w-full max-w-2xl h-auto opacity-80" />
    </div>

    {/* Gold pill badge */}
    <div className="flex justify-center mb-5">
      <span className="inline-flex items-center gap-2 rounded-full border border-secondary/40 bg-secondary/15 px-4 py-1.5 text-xs uppercase tracking-[0.2em] text-secondary-foreground/90">
        <Clock className="h-3.5 w-3.5 text-secondary" aria-hidden />
        Quiz couple — 5 à 7 minutes
      </span>
    </div>

    {/* H1 wrapped in gold frame */}
    <div className="relative mx-auto max-w-2xl px-6 md:px-10 py-6 md:py-8 mb-6 text-center">
      <GoldFrame />
      <h1 className="relative font-display text-3xl md:text-5xl leading-tight text-foreground">
        {copy.hero.title}
      </h1>
    </div>

    <p className="text-lg text-muted-foreground mb-8 max-w-xl mx-auto text-center">
      {copy.hero.subtitle}
    </p>

    <ul className="space-y-3 mb-10 max-w-xl mx-auto">
      {copy.hero.bullets.map((b) => (
        <li key={b} className="flex items-start gap-3 text-foreground/90">
          <span
            aria-hidden
            className="mt-2 inline-block h-1.5 w-1.5 rounded-full bg-secondary shrink-0"
          />
          <span>{b}</span>
        </li>
      ))}
    </ul>

    <div className="flex justify-center">
      <Button
        size="lg"
        onClick={onStart}
        className="bg-gradient-terracotta text-primary-foreground shadow-soft hover:opacity-95 hover:shadow-gold px-10 h-12 text-base transition-all"
      >
        {copy.hero.cta}
      </Button>
    </div>

    <p className="mt-10 text-sm text-muted-foreground italic max-w-xl mx-auto text-center">
      {copy.hero.signature}
    </p>

    <p className="mt-4 flex items-center justify-center gap-2 text-xs text-muted-foreground/80">
      <ShieldCheck className="h-3.5 w-3.5 text-secondary/70" aria-hidden />
      Anonyme · données stockées en Europe (RGPD)
    </p>
  </section>
);

/* ---------- Quiz ---------- */

const QuizScreen = ({
  question,
  qIndex,
  total,
  progress,
  currentAnswer,
  onAnswer,
  onBack,
}: {
  question: typeof QUESTIONS[number];
  qIndex: number;
  total: number;
  progress: number;
  currentAnswer: Choice | null;
  onAnswer: (c: Choice) => void;
  onBack: () => void;
}) => {
  const q = question;
  return (
    <section className="pt-8 animate-in fade-in duration-300">
      <div className="flex items-center justify-between mb-3 text-xs text-muted-foreground">
        <span className="font-medium">
          Question {qIndex + 1} / {total}
        </span>
        <span className="text-secondary-foreground/80 font-medium">{progress}%</span>
      </div>
      {/* Custom gold progress bar — replaces shadcn Progress for Azwaj signature */}
      <div
        className="mb-10 h-1.5 w-full overflow-hidden rounded-full bg-muted"
        role="progressbar"
        aria-valuenow={progress}
        aria-valuemin={0}
        aria-valuemax={100}
      >
        <div
          className="h-full bg-gradient-gold transition-[width] duration-500 ease-out"
          style={{ width: `${progress}%` }}
        />
      </div>

      {/* Keyed wrapper forces slide animation on each question change */}
      <div key={qIndex} className="slide-in-right">
        <h2 className="font-display text-2xl md:text-3xl mb-8 text-foreground leading-snug">
          {q.text}
        </h2>

        <div className="space-y-3">
          {q.options.map((opt, idx) => {
            const selected = currentAnswer === opt.key;
            // Visual position letter (A/B/C/D) based on shuffled display order,
            // NOT opt.key which is tied to scoring.
            const visualLetter = String.fromCharCode(65 + idx);
            return (
              <button
                key={opt.key}
                onClick={() => onAnswer(opt.key)}
                className={[
                  "option-btn w-full text-left rounded-xl border px-5 py-4 bg-card",
                  "shadow-sm",
                  selected
                    ? "border-primary bg-primary/10 text-foreground ring-1 ring-primary/40"
                    : "border-border",
                ].join(" ")}
              >
                <span className="font-medium text-sm text-secondary-foreground mr-3 font-display">
                  {visualLetter}.
                </span>
                <span className="text-foreground/90">{opt.label}</span>
              </button>
            );
          })}
        </div>
      </div>

      <div className="mt-10">
        <Button variant="ghost" onClick={onBack} className="text-muted-foreground">
          ← Précédent
        </Button>
      </div>
    </section>
  );
};

/* ---------- Capture ---------- */

const CaptureScreen = ({
  firstName,
  email,
  consent,
  errors,
  submitting,
  setFirstName,
  setEmail,
  setConsent,
  onSubmit,
}: {
  firstName: string;
  email: string;
  consent: boolean;
  errors: Record<string, string>;
  submitting: boolean;
  setFirstName: (v: string) => void;
  setEmail: (v: string) => void;
  setConsent: (v: boolean) => void;
  onSubmit: () => void;
}) => (
  <section className="pt-8 max-w-lg mx-auto animate-in fade-in duration-500">
    {/* Reassuring hint — soft gold pill */}
    <div className="flex justify-center mb-5">
      <span className="inline-flex items-center gap-2 rounded-full bg-secondary/15 border border-secondary/30 px-3.5 py-1 text-xs text-secondary-foreground/90">
        <ShieldCheck className="h-3.5 w-3.5 text-secondary" aria-hidden />
        Ton portrait est prêt à être envoyé
      </span>
    </div>

    <h2 className="font-display text-3xl mb-3 text-foreground text-center">
      {copy.capture.title}
    </h2>
    <p className="text-muted-foreground mb-8 text-center">{copy.capture.subtitle}</p>

    <Card className="p-6 md:p-8 shadow-card border-border/70 bg-card/90 backdrop-blur-sm">
      <form
        onSubmit={(e) => {
          e.preventDefault();
          onSubmit();
        }}
        className="space-y-5"
      >
        <div>
          <Label htmlFor="firstName">{copy.capture.firstName}</Label>
          <Input
            id="firstName"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            maxLength={80}
            autoComplete="given-name"
            className="mt-1.5 focus-gold"
          />
          {errors.firstName && (
            <p className="text-sm text-destructive mt-1">{errors.firstName}</p>
          )}
        </div>

        <div>
          <Label htmlFor="email">{copy.capture.email}</Label>
          <Input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            maxLength={255}
            autoComplete="email"
            className="mt-1.5 focus-gold"
          />
          {errors.email && (
            <p className="text-sm text-destructive mt-1">{errors.email}</p>
          )}
        </div>

        <div className="flex items-start gap-3 pt-1">
          <Checkbox
            id="consent"
            checked={consent}
            onCheckedChange={(v) => setConsent(v === true)}
            className="mt-1"
          />
          <Label
            htmlFor="consent"
            className="text-sm leading-relaxed text-muted-foreground font-normal cursor-pointer"
          >
            {copy.capture.consent}{" "}
            <Link
              to="/confidentialite"
              className="underline text-primary hover:text-primary/80"
            >
              {copy.capture.privacyLink}
            </Link>
            .
          </Label>
        </div>
        {errors.consent && (
          <p className="text-sm text-destructive">{errors.consent}</p>
        )}

        <Button
          type="submit"
          disabled={submitting}
          className="w-full bg-gradient-terracotta text-primary-foreground h-12 text-base shadow-soft hover:shadow-gold transition-shadow"
        >
          {submitting ? "Ton portrait se prépare…" : copy.capture.submit}
        </Button>
      </form>
    </Card>
  </section>
);

/* ---------- Result ---------- */

const ResultScreen = ({
  archetype,
  firstName,
  onRestart,
}: {
  archetype: ArchetypeId;
  firstName: string;
  onRestart: () => void;
}) => {
  const a = ARCHETYPES[archetype];
  const img = ARCHETYPE_IMAGES[archetype];
  return (
    <section className="pt-8">
      <p className="reveal-step text-sm uppercase tracking-[0.25em] text-secondary-foreground/80 mb-3">
        {firstName ? `${firstName}, votre archétype` : copy.result.yourArchetype}
      </p>
      <h2 className="reveal-step delay-1 font-display text-4xl md:text-5xl text-foreground mb-6">
        {a.name}
      </h2>

      <div className="reveal-step delay-2 relative mb-8">
        {/* Golden frame hugging the archetype image */}
        <div className="pointer-events-none absolute -inset-2 md:-inset-3">
          <GoldFrame />
        </div>
        <Card className="relative overflow-hidden shadow-card border-border/70">
          <img
            src={img}
            alt={`Visuel de l'archétype ${a.name}`}
            width={1024}
            height={1024}
            className="w-full aspect-square object-cover"
          />
        </Card>
      </div>

      <p className="reveal-step delay-3 text-lg text-foreground/90 mb-10 leading-relaxed">
        {a.description}
      </p>

      <div className="grid md:grid-cols-2 gap-5 mb-8">
        <Card className="p-6 bg-secondary-soft border-secondary/30">
          <h3 className="font-display text-xl mb-3 text-foreground">
            {copy.result.forces}
          </h3>
          <ul className="space-y-2 text-sm text-foreground/85">
            {a.forces.map((f) => (
              <li key={f} className="flex gap-2">
                <span className="text-secondary">✓</span>
                <span>{f}</span>
              </li>
            ))}
          </ul>
        </Card>

        <Card className="p-6 bg-primary-soft border-primary/30">
          <h3 className="font-display text-xl mb-3 text-foreground">
            {copy.result.challenges}
          </h3>
          <ul className="space-y-2 text-sm text-foreground/85">
            {a.challenges.map((c) => (
              <li key={c} className="flex gap-2">
                <span className="text-primary">→</span>
                <span>{c}</span>
              </li>
            ))}
          </ul>
        </Card>
      </div>

      <Card className="p-6 mb-8 border-border/70">
        <h3 className="font-display text-xl mb-3 text-foreground">
          {copy.result.spiritual}
        </h3>
        <p className="text-foreground/85 leading-relaxed italic">{a.spiritual}</p>
      </Card>

      <Card className="p-6 mb-8 border-border/70">
        <h3 className="font-display text-xl mb-4 text-foreground">
          {copy.result.actions}
        </h3>
        <ol className="space-y-3 text-foreground/90">
          {a.actions.map((act, i) => (
            <li key={act} className="flex gap-3">
              <span className="font-display text-primary text-lg leading-none">
                {i + 1}.
              </span>
              <span>{act}</span>
            </li>
          ))}
        </ol>
      </Card>

      <div className="rounded-xl bg-secondary/15 border border-secondary/30 p-5 mb-10 text-sm text-foreground/85">
        📩 {copy.result.pdfNotice}
      </div>

      <ShareBlock archetype={archetype} archetypeName={a.name} imageUrl={img} />

      <p className="mt-10 text-xs text-muted-foreground/80 italic leading-relaxed">
        {copy.result.disclaimer}
      </p>

      <div className="mt-8 flex flex-wrap gap-3">
        <Button variant="ghost" onClick={onRestart}>
          {copy.result.restart}
        </Button>
      </div>
    </section>
  );
};

/* ---------- Share block ---------- */

const ShareBlock = ({
  archetype,
  archetypeName,
  imageUrl,
}: {
  archetype: ArchetypeId;
  archetypeName: string;
  imageUrl: string;
}) => {
  const { toast } = useToast();
  const pageUrl =
    typeof window !== "undefined"
      ? window.location.origin + "/"
      : "https://quiz.azwaj.be/";
  const shareText = `${copy.result.shareText} Mon archétype : ${archetypeName}.`;
  const encodedUrl = encodeURIComponent(pageUrl);
  const encodedText = encodeURIComponent(shareText);

  const track = (network: string) => {
    try {
      // @ts-expect-error window.umami is injected by the Umami script tag in index.html
      window.umami?.track?.("quiz-share", { network, archetype });
    } catch {
      /* noop */
    }
  };

  const copyLink = async () => {
    try {
      await navigator.clipboard.writeText(pageUrl);
      toast({ title: copy.result.shareCopied });
      track("copy");
    } catch {
      toast({
        title: "Impossible de copier le lien",
        variant: "destructive",
      });
    }
  };

  return (
    <Card className="p-6 mb-4 border-border/70">
      <h3 className="font-display text-xl mb-4 text-foreground">
        {copy.result.shareTitle}
      </h3>
      <div className="flex flex-wrap gap-3 items-center">
        <Button
          asChild
          variant="outline"
          size="sm"
          onClick={() => track("whatsapp")}
          aria-label={copy.result.shareWhatsapp}
          className="gap-2"
        >
          <a
            href={`https://wa.me/?text=${encodedText}%20${encodedUrl}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <WhatsAppIcon className="h-5 w-5" />
            <span className="hidden sm:inline">{copy.result.shareWhatsapp}</span>
          </a>
        </Button>
        <Button
          asChild
          variant="outline"
          size="sm"
          onClick={() => track("facebook")}
          aria-label={copy.result.shareFacebook}
          className="gap-2"
        >
          <a
            href={`https://www.facebook.com/sharer/sharer.php?u=${encodedUrl}&quote=${encodedText}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <FacebookIcon className="h-5 w-5" />
            <span className="hidden sm:inline">{copy.result.shareFacebook}</span>
          </a>
        </Button>
        <Button
          asChild
          variant="outline"
          size="sm"
          onClick={() => track("linkedin")}
          aria-label={copy.result.shareLinkedin}
          className="gap-2"
        >
          <a
            href={`https://www.linkedin.com/sharing/share-offsite/?url=${encodedUrl}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <LinkedInIcon className="h-5 w-5" />
            <span className="hidden sm:inline">{copy.result.shareLinkedin}</span>
          </a>
        </Button>
        <Button
          variant="outline"
          size="sm"
          onClick={copyLink}
          aria-label={copy.result.shareCopy}
          className="gap-2"
        >
          <Link2 className="h-4 w-4" aria-hidden />
          <span className="hidden sm:inline">{copy.result.shareCopy}</span>
        </Button>
        <Button
          asChild
          variant="ghost"
          size="sm"
          onClick={() => track("download-image")}
          aria-label={copy.result.share}
          className="gap-2"
        >
          <a
            href={imageUrl}
            download={`mon-couple-aujourdhui-${archetype}.jpg`}
          >
            <Download className="h-4 w-4" aria-hidden />
            <span className="hidden sm:inline">{copy.result.share}</span>
          </a>
        </Button>
      </div>
    </Card>
  );
};

export default Index;
