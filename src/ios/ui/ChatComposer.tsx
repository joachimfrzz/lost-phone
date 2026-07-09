interface ChatComposerProps {
  theme?: "messages" | "whatsapp" | "signal" | "messenger" | "gemini" | "grok" | "snapchat";
  placeholder?: string;
  readOnly?: boolean;
}

/** Barre de saisie iOS en bas du fil de conversation */
export function ChatComposer({ theme = "messages", placeholder = "iMessage", readOnly = true }: ChatComposerProps) {
  const sendColor =
    theme === "whatsapp" ? "#25d366"
    : theme === "signal" ? "#2d6cdf"
    : theme === "messenger" ? "#0084ff"
    : theme === "grok" ? "#fff"
    : theme === "gemini" ? "#4285f4"
    : theme === "snapchat" ? "#fffc00"
    : "#007aff";
  return (
    <footer className={`ui-composer ui-composer--${theme} ${readOnly ? "ui-composer--readonly" : ""}`}>
      <button type="button" className="ui-composer__plus" aria-label="Ajouter" disabled={readOnly}>
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" stroke="currentColor" strokeWidth="2">
          <circle cx="11" cy="11" r="9" /><path d="M11 7v8M7 11h8" strokeLinecap="round" />
        </svg>
      </button>
      <div className="ui-composer__field">
        <span className="ui-composer__placeholder">{placeholder}</span>
      </div>
      <button type="button" className="ui-composer__send" aria-label="Envoyer" disabled={readOnly}>
        <svg width="28" height="28" viewBox="0 0 28 28" aria-hidden>
          <circle cx="14" cy="14" r="14" fill={sendColor} />
          <path d="M14 8l-2 6h4l-2 6 6-8h-4l2-4z" fill={theme === "grok" ? "#000" : "#fff"} transform="translate(0,-1)" />
        </svg>
      </button>
    </footer>
  );
}
