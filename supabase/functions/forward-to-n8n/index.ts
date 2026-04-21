// Forward a quiz submission to the n8n outbound webhook.
// The N8N_WEBHOOK_URL secret will be added later by the user.
import { createClient, corsHeaders } from "https://esm.sh/@supabase/supabase-js@2.95.0";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

interface Payload {
  submission_id: string;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const body = (await req.json()) as Partial<Payload>;
    if (!body.submission_id || typeof body.submission_id !== "string") {
      return new Response(JSON.stringify({ error: "submission_id required" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const webhookUrl = Deno.env.get("N8N_WEBHOOK_URL");
    if (!webhookUrl) {
      console.warn("N8N_WEBHOOK_URL not configured — skipping forward.");
      return new Response(
        JSON.stringify({ ok: true, forwarded: false, reason: "no_webhook_url" }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
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

    let status = "ok";
    let responseText = "";
    try {
      const r = await fetch(webhookUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          source: "mon-couple-aujourdhui",
          event: "quiz_completed",
          submission,
        }),
      });
      responseText = (await r.text()).slice(0, 500);
      if (!r.ok) status = `http_${r.status}`;
    } catch (e) {
      status = "fetch_error";
      responseText = String(e).slice(0, 500);
    }

    await supabase
      .from("quiz_submissions")
      .update({
        webhook_status: status,
        webhook_attempted_at: new Date().toISOString(),
        webhook_response: responseText,
      })
      .eq("id", body.submission_id);

    return new Response(JSON.stringify({ ok: status === "ok", status }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (e) {
    console.error("forward-to-n8n error", e);
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
