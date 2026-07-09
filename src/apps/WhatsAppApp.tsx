import { useState } from "react";
import { adaptThreads } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { ChatComposer } from "../ios/ui/ChatComposer";
import { ChatThread } from "../ios/ui/ChatThread";
import { Avatar, Cell, Group } from "../ios/ui/List";
import { formatShortDate } from "../ios/ui/utils";

export function WhatsAppApp({ data }: { data: unknown }) {
  const threads = adaptThreads(data);
  const [active, setActive] = useState<number | null>(null);

  if (active != null && threads[active]) {
    const t = threads[active];
    return (
      <AppShell theme="whatsapp">
        <header className="ui-nav ui-nav--wa ui-nav--wa-thread">
          <div className="ui-nav__side">
            <button type="button" className="ui-nav__back ui-nav__back--wa" onClick={() => setActive(null)}>
              ← Chats
            </button>
          </div>
          <h1 className="ui-nav__title">{t.contact}</h1>
          <div className="ui-nav__side ui-nav__side--right" />
        </header>
        <ChatThread
          theme="whatsapp"
          scrollToEnd
          messages={t.messages.map((m) => ({ id: m.id, text: m.text, outgoing: m.outgoing, time: m.time }))}
        />
        <ChatComposer theme="whatsapp" placeholder="Message" readOnly />
      </AppShell>
    );
  }

  return (
    <AppShell theme="whatsapp">
      <header className="ui-nav ui-nav--wa">
        <div className="ui-nav__side" />
        <h1 className="ui-nav__title">WhatsApp</h1>
        <div className="ui-nav__side ui-nav__side--right" />
      </header>
      <div className="ui-wa-chats ui-scroll">
        <Group>
          {threads.map((t, i) => (
            <Cell
              key={i}
              icon={<Avatar name={t.contact} color="#25d366" />}
              label={t.contact}
              subtitle={t.preview}
              detail={t.messages.at(-1)?.time ? formatShortDate(t.messages.at(-1)?.time) : undefined}
              chevron
              onClick={() => setActive(i)}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
