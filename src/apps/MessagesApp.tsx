import { useState } from "react";
import { adaptThreads } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { ChatComposer } from "../ios/ui/ChatComposer";
import { ChatThread } from "../ios/ui/ChatThread";
import { Avatar, Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";
import { SFCompose } from "../ios/ui/SFSymbols";
import { formatShortDate } from "../ios/ui/utils";

export function MessagesApp({ data }: { data: unknown }) {
  const threads = adaptThreads(data);
  const [active, setActive] = useState<number | null>(null);

  if (active != null && threads[active]) {
    const t = threads[active];
    return (
      <AppShell theme="messages">
        <NavBar
          title={t.contact}
          backLabel="Messages"
          onBack={() => setActive(null)}
          right={
            <span className="ui-nav__avatar-sm">
              <Avatar name={t.contact} color="#8e8e93" />
            </span>
          }
        />
        <ChatThread
          theme="messages"
          messages={t.messages.map((m) => ({ id: m.id, text: m.text, outgoing: m.outgoing, time: m.time }))}
        />
        <ChatComposer theme="messages" placeholder="iMessage" />
      </AppShell>
    );
  }

  return (
    <AppShell theme="messages">
      <header className="ui-nav ui-nav--messages-inbox">
        <div className="ui-nav__side" />
        <h1 className="ui-nav__title">Messages</h1>
        <div className="ui-nav__side ui-nav__side--right">
          <button type="button" className="ui-nav__compose" aria-label="Nouveau message">
            <SFCompose />
          </button>
        </div>
      </header>
      <div className="ui-scroll">
        <Group>
          {threads.map((t, i) => (
            <Cell
              key={i}
              icon={<Avatar name={t.contact} color="#8e8e93" />}
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
