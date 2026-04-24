// Forward a quiz submission to the n8n outbound webhook.
// Spec: POST https://n8n.azwaj.be/webhook/quiz-v2 with the exact payload shape below.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.95.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const N8N_WEBHOOK_URL = "https://n8n.azwaj.be/webhook/quiz-v2";

// Map internal archetype ids to the PascalCase keys expected by n8n.
const ARCHETYPE_TO_PASCAL: Record<string, string> = {
  silencieux: "Silencieux",
  eloignes: "Eloignes",
  debordes: "Debordes",
  "en-construction": "EnConstruction",
  "complices-fatigues": "ComplicesFatigues",
  survivants: "Survivants",
};

function toResponses(answers: unknown): Record<string, string> {
  const out: Record<string, string> = {};
  if (Array.isArray(answers)) {
    answers.forEach((a, i) => {
      if (typeof a === "string") out[`Q${i + 1}`] = a;
    });
  }
  return out;
}

function toPascalScores(scores: unknown): Record<string, number> {
  const out: Record<string, number> = {};
  if (scores && typeof scores === "object") {
    for (const [k, v] of Object.entries(scores as Record<string, unknown>)) {
      const pk = ARCHETYPE_TO_PASCAL[k] ?? k;
      out[pk] = typeof v === "number" ? v : 0;
    }
  }
  return out;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const body = (await req.json()) as { submission_id?: string };
    if (!body.submission_id || typeof body.submission_id !== "string") {
      return new Response(JSON.stringify({ error: "submission_id required" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    const { data: submission, error } = await supabase
      .from("quiz_submissions")
      .select("*")
      .eq("id", body.submission_id)
      .maybeSingle();

    if (error || !submission) {
      return new Response(JSON.stringify({ error: "submission not found" }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const payload = {
      prenom: submission.first_name,
      email: submission.email,
      archetype: submission.archetype,
      scores: submission.scores,
      responses: toResponses(submission.answers),
      timestamp: new Date().toISOString(),
      consent_rgpd: submission.consent_given === true,
    };

    let status = "ok";
    let responseText = "";
    let httpStatus = 0;
    let pdfUrl: string | null = null;
    try {
      const r = await fetch(N8N_WEBHOOK_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      httpStatus = r.status;
      const rawText = await r.text();
      responseText = rawText.slice(0, 500);
      if (!r.ok) status = `http_${r.status}`;
      // Parse n8n response for pdf_url (n8n workflow returns { pdf_url, ... } on success)
      try {
        const parsed = JSON.parse(rawText);
        if (parsed && typeof parsed.pdf_url === "string" && parsed.pdf_url.length > 10) {
          pdfUrl = parsed.pdf_url;
        } else if (Array.isArray(parsed) && parsed[0]?.pdf_url) {
          pdfUrl = parsed[0].pdf_url;
        }
      } catch { /* not JSON */ }
    } catch (e) {
      status = "fetch_error";
      responseText = String(e).slice(0, 500);
    }

    // Update submission with webhook status + pdf_url (if returned by n8n)
    const updatePayload: Record<string, unknown> = {
      webhook_status: status,
      webhook_attempted_at: new Date().toISOString(),
      webhook_response: responseText,
    };
    if (pdfUrl) updatePayload.pdf_url = pdfUrl;

    await supabase
      .from("quiz_submissions")
      .update(updatePayload)
      .eq("id", body.submission_id);

    // Enqueue the 5 Resend-driven nurture emails (idempotent via ON CONFLICT).
    // Failure here is non-blocking — n8n cron will retry, and we log the error.
    let enqueued = 0;
    let enqueueErr: string | null = null;
    try {
      const { data: enq, error: enqError } = await supabase.rpc(
        "enqueue_quiz_v2_emails",
        { p_submission_id: body.submission_id },
      );
      if (enqError) enqueueErr = enqError.message;
      else enqueued = typeof enq === "number" ? enq : 0;
    } catch (e) {
      enqueueErr = String(e).slice(0, 300);
    }

    return new Response(
      JSON.stringify({
        ok: status === "ok",
        status,
        http_status: httpStatus,
        enqueued,
        enqueue_error: enqueueErr,
        pdf_url: pdfUrl,
      }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  } catch (e) {
    console.error("forward-to-n8n error", e);
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
