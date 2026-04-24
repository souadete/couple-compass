// Secure bridge between n8n and the protected Supabase RPCs.
// Uses the service_role key (auto-injected by Lovable Cloud) + a shared secret
// (N8N_WORKER_SECRET, added manually via Lovable Secrets UI) to gate access.
// n8n calls this function instead of Supabase REST directly, avoiding the need
// to expose the service_role key to n8n.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2.95.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type, x-n8n-secret",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const N8N_WORKER_SECRET = Deno.env.get("N8N_WORKER_SECRET");

// Whitelist of callable RPCs (prevent arbitrary function invocation)
const ALLOWED_ACTIONS = new Set([
  "get_quiz_v2_ready_emails",
  "get_quiz_v2_email_template",
  "mark_quiz_v2_email_sent",
  "mark_quiz_v2_email_failed",
  "enqueue_quiz_v2_emails",
  "get_quiz_v2_email_stats",
  "unsubscribe_quiz_v2_by_token",
]);

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return json({ error: "method_not_allowed" }, 405);

  if (!N8N_WORKER_SECRET) {
    return json({ error: "server_misconfig", detail: "N8N_WORKER_SECRET not set" }, 500);
  }

  // Auth: shared secret either in header X-N8N-Secret or body.secret
  const headerSecret = req.headers.get("x-n8n-secret");
  let body: { action?: string; params?: Record<string, unknown>; secret?: string };
  try {
    body = await req.json();
  } catch {
    return json({ error: "invalid_json" }, 400);
  }

  const secret = headerSecret || body.secret;
  if (!secret || secret !== N8N_WORKER_SECRET) {
    return json({ error: "unauthorized" }, 401);
  }

  const { action, params } = body;
  if (!action || !ALLOWED_ACTIONS.has(action)) {
    return json({ error: "unknown_action", allowed: [...ALLOWED_ACTIONS] }, 400);
  }

  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
  try {
    const { data, error } = await supabase.rpc(action, params || {});
    if (error) return json({ error: "rpc_error", detail: error.message }, 500);
    return json({ ok: true, data });
  } catch (e) {
    return json({ error: "exception", detail: String(e).slice(0, 500) }, 500);
  }
});
