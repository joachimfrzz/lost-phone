import { useEffect, useRef } from "react";
import { formatTime } from "./utils";

export interface ChatMessage {
  id?: string;
  text: string;
  outgoing: boolean;
  time?: string;
}

interface ChatThreadProps {
  messages: ChatMessage[];
  theme?: "messages" | "whatsapp" | "signal" | "messenger" | "gemini" | "grok" | "snapchat" | "tinder";
  scrollToEnd?: boolean;
}

/** Fil de conversation style iMessage / WhatsApp / Signal */
export function ChatThread({ messages, theme = "messages", scrollToEnd = false }: ChatThreadProps) {
  const endRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (scrollToEnd) {
      endRef.current?.scrollIntoView({ behavior: "instant" });
    }
  }, [messages, scrollToEnd]);

  return (
    <div className={`ui-chat ui-chat--${theme}`}>
      {messages.map((m, i) => (
        <div key={m.id ?? i} className={`ui-chat__row ${m.outgoing ? "ui-chat__row--out" : "ui-chat__row--in"}`}>
          <div className="ui-chat__bubble">
            <p>{m.text}</p>
            {m.time && <time>{formatTime(m.time)}</time>}
          </div>
        </div>
      ))}
      {scrollToEnd && <div ref={endRef} />}
    </div>
  );
}
