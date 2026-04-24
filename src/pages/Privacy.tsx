import { Link } from "react-router-dom";
import { copy } from "@/lib/i18n";

const Privacy = () => (
  <div className="min-h-screen bg-gradient-warm">
    <header className="container max-w-3xl py-6">
      <Link to="/" className="font-display text-xl text-foreground hover:text-primary transition">
        ← {copy.appName}
      </Link>
    </header>
    <main className="container max-w-3xl pb-20">
      <h1 className="font-display text-4xl text-foreground mb-2">Politique de confidentialité</h1>
      <p className="text-sm text-muted-foreground mb-10">Dernière mise à jour : avril 2026</p>

      <div className="prose prose-sm max-w-none space-y-6 text-foreground/90 leading-relaxed">
        <section>
          <h2 className="font-display text-2xl text-foreground mb-2">Qui sommes-nous ?</h2>
          <p>
            « {copy.appName} » est un outil édité par <strong>Souade Taje</strong>, sexologue
            clinicienne (formation UCL), dans le cadre du projet Azwaj
            (<a href="https://azwaj.be" className="underline hover:text-primary">azwaj.be</a>)
            — plateforme d'accompagnement dédiée aux couples musulmans francophones
            autour de l'intimité, de la communication conjugale et du lien entre foi et
            relation. Le site propose un quiz d'auto-évaluation gratuit de la dynamique
            de couple.
          </p>
          <p className="mt-3">
            La politique de confidentialité complète du projet Azwaj est consultable
            sur{" "}
            <a
              href="https://azwaj.be/politique-de-confidentialite/"
              className="underline hover:text-primary"
              target="_blank"
              rel="noopener noreferrer"
            >
              azwaj.be/politique-de-confidentialite
            </a>
            . La présente page en est un complément spécifique au quiz.
          </p>
        </section>

        <section>
          <h2 className="font-display text-2xl text-foreground mb-2">Quelles données collectons-nous ?</h2>
          <ul className="list-disc pl-5 space-y-1">
            <li>Votre prénom</li>
            <li>Votre adresse email</li>
            <li>Vos réponses aux 21 questions du quiz</li>
            <li>Votre archétype calculé et le score détaillé</li>
            <li>Des informations techniques minimales (langue, navigateur, page d'origine)</li>
          </ul>
          <p className="mt-3">
            Nous ne demandons aucune donnée sensible (origine, opinion politique,
            orientation, données de santé identifiables). Le quiz est anonyme dans son
            contenu — aucune information personnelle n'est requise pour répondre aux questions.
          </p>
        </section>

        <section>
          <h2 className="font-display text-2xl text-foreground mb-2">Pourquoi ces données ?</h2>
          <ul className="list-disc pl-5 space-y-1">
            <li>Vous envoyer votre PDF personnalisé par email</li>
            <li>Vous adresser une séquence de 5 emails d'accompagnement sur 12 jours</li>
            <li>Améliorer le contenu du quiz et des ressources (analyse agrégée)</li>
          </ul>
        </section>

        <section>
          <h2 className="font-display text-2xl text-foreground mb-2">Où sont stockées vos données ?</h2>
          <p>
            Vos données sont hébergées dans l'Union européenne, sur une infrastructure
            sécurisée (Supabase, région UE). Elles ne sont <strong>jamais partagées
            avec des tiers</strong> à des fins commerciales ou publicitaires.
          </p>
          <p>
            Pour l'envoi des emails, nous utilisons un service d'automatisation
            (n8n auto-hébergé) et un service d'emailing (Encharge), liés
            contractuellement par les exigences du RGPD.
          </p>
        </section>

        <section>
          <h2 className="font-display text-2xl text-foreground mb-2">Vos droits</h2>
          <p>Conformément au RGPD, vous disposez à tout moment des droits suivants :</p>
          <ul className="list-disc pl-5 space-y-1">
            <li>Accès à vos données</li>
            <li>Rectification</li>
            <li>Suppression (« droit à l'oubli »)</li>
            <li>Portabilité</li>
            <li>Opposition au traitement</li>
            <li>Désabonnement immédiat de la séquence email (lien dans chaque email)</li>
          </ul>
          <p className="mt-3">
            Pour exercer ces droits, écrivez à{" "}
            <a href="mailto:salam@azwaj.be" className="underline hover:text-primary">
              salam@azwaj.be
            </a>
            . Nous répondrons sous 30 jours maximum.
          </p>
        </section>

        <section>
          <h2 className="font-display text-2xl text-foreground mb-2">Cookies</h2>
          <p>
            Ce site n'utilise <strong>aucun cookie de traçage publicitaire</strong>.
            Seuls des cookies techniques strictement nécessaires au fonctionnement
            du site peuvent être utilisés.
          </p>
        </section>

        <section>
          <h2 className="font-display text-2xl text-foreground mb-2">Durée de conservation</h2>
          <p>
            Vos réponses et résultats sont conservés tant que vous n'avez pas
            demandé leur suppression. Les emails sont retirés de la séquence dès
            désabonnement, et supprimés sur demande explicite.
          </p>
        </section>
      </div>
    </main>
  </div>
);

export default Privacy;
