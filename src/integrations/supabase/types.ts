export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      quiz_submissions: {
        Row: {
          answers: Json
          archetype: string
          consent_given: boolean
          created_at: string
          email: string
          first_name: string
          id: string
          language: string
          percentages: Json
          referrer: string | null
          scores: Json
          user_agent: string | null
          webhook_attempted_at: string | null
          webhook_response: string | null
          webhook_status: string
        }
        Insert: {
          answers: Json
          archetype: string
          consent_given?: boolean
          created_at?: string
          email: string
          first_name: string
          id?: string
          language?: string
          percentages: Json
          referrer?: string | null
          scores: Json
          user_agent?: string | null
          webhook_attempted_at?: string | null
          webhook_response?: string | null
          webhook_status?: string
        }
        Update: {
          answers?: Json
          archetype?: string
          consent_given?: boolean
          created_at?: string
          email?: string
          first_name?: string
          id?: string
          language?: string
          percentages?: Json
          referrer?: string | null
          scores?: Json
          user_agent?: string | null
          webhook_attempted_at?: string | null
          webhook_response?: string | null
          webhook_status?: string
        }
        Relationships: []
      }
      quiz_v2_email_queue: {
        Row: {
          archetype: string
          attempt_count: number
          created_at: string
          day_delay: number
          email: string
          error_message: string | null
          first_name: string
          id: string
          last_attempt_at: string | null
          mail_code: string
          resend_message_id: string | null
          send_at: string
          sent_at: string | null
          submission_id: string
          unsub_token: string
          unsubscribed_at: string | null
        }
        Insert: {
          archetype: string
          attempt_count?: number
          created_at?: string
          day_delay: number
          email: string
          error_message?: string | null
          first_name: string
          id?: string
          last_attempt_at?: string | null
          mail_code: string
          resend_message_id?: string | null
          send_at: string
          sent_at?: string | null
          submission_id: string
          unsub_token?: string
          unsubscribed_at?: string | null
        }
        Update: {
          archetype?: string
          attempt_count?: number
          created_at?: string
          day_delay?: number
          email?: string
          error_message?: string | null
          first_name?: string
          id?: string
          last_attempt_at?: string | null
          mail_code?: string
          resend_message_id?: string | null
          send_at?: string
          sent_at?: string | null
          submission_id?: string
          unsub_token?: string
          unsubscribed_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "quiz_v2_email_queue_submission_id_fkey"
            columns: ["submission_id"]
            isOneToOne: false
            referencedRelation: "quiz_submissions"
            referencedColumns: ["id"]
          },
        ]
      }
      quiz_v2_email_templates: {
        Row: {
          archetype: string
          day_delay: number
          html: string
          mail_code: string
          preheader: string | null
          subject: string
          updated_at: string
        }
        Insert: {
          archetype: string
          day_delay: number
          html: string
          mail_code: string
          preheader?: string | null
          subject: string
          updated_at?: string
        }
        Update: {
          archetype?: string
          day_delay?: number
          html?: string
          mail_code?: string
          preheader?: string | null
          subject?: string
          updated_at?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      enqueue_quiz_v2_emails: {
        Args: { p_submission_id: string }
        Returns: number
      }
      get_quiz_stats: { Args: never; Returns: Json }
      get_quiz_v2_email_stats: { Args: never; Returns: Json }
      get_quiz_v2_email_template: {
        Args: { p_mail_code: string }
        Returns: {
          html: string
          mail_code: string
          preheader: string
          subject: string
        }[]
      }
      get_quiz_v2_ready_emails: {
        Args: { p_limit?: number }
        Returns: {
          archetype: string
          attempt_count: number
          day_delay: number
          email: string
          first_name: string
          id: string
          mail_code: string
          send_at: string
          submission_id: string
          unsub_token: string
        }[]
      }
      get_retryable_submission_ids: {
        Args: never
        Returns: {
          archetype: string
          created_at: string
          email: string
          id: string
          webhook_status: string
        }[]
      }
      mark_quiz_v2_email_failed: {
        Args: { p_error: string; p_id: string }
        Returns: undefined
      }
      mark_quiz_v2_email_sent: {
        Args: { p_id: string; p_resend_message_id: string }
        Returns: undefined
      }
      submit_quiz: {
        Args: {
          p_answers: Json
          p_archetype: string
          p_consent_given: boolean
          p_email: string
          p_first_name: string
          p_language?: string
          p_percentages: Json
          p_referrer?: string
          p_scores: Json
          p_user_agent?: string
        }
        Returns: string
      }
      unsubscribe_quiz_v2_by_token: {
        Args: { p_token: string }
        Returns: {
          affected_email: string
          affected_rows: number
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
