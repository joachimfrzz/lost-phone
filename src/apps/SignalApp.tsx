import { useState } from "react";
import { adaptSignal } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { ChatComposer } from "../ios/ui/ChatComposer";
import { ChatThread } from "../ios/ui/ChatThread";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle, NavBar } from "../ios/ui/NavBar";

export function SignalApp({ data }: { data: unknown }) {
  const threads = adaptSignal(data);
  const [active, setActive] = useState<number | null>(null);

  if (active != null && threads[active]) {
    const t = threads[active];
    return (
      <AppShell theme="signal">
        <NavBar title={t.contact} backLabel="Signal" onBack={() => setActive(null)} />
        <div className="ui-signal-lock">
          <svg width="12" height="14" viewBox="0 0 12 14" fill="currentColor" aria-hidden>
            <path d="M6 0C3.8 0 2 1.8 2 4v2H1a1 1 0 0 0-1 1v6a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1h-1V4c0-2.2-1.8-4-4-4zm2 6H4V4c0-1.1.9-2 2-2s2 .9 2 2v2z" />
          </svg>
          <span>Chiffré de bout en bout</span>
        </div>
        <ChatThread
          theme="signal"
          messages={t.messages.map((m) => ({ id: m.id, text: m.text, outgoing: m.outgoing, time: m.time }))}
        />
        <ChatComposer theme="signal" placeholder="Message Signal" />
      </AppShell>
    );
  }

  return (
    <AppShell theme="signal">
      <LargeTitle title="Signal" subtitle="Chiffré de bout en bout" />
      <div className="ui-scroll">
        <Group>
          {threads.map((t, i) => (
            <Cell
              key={i}
              icon={<span className="ui-avatar" style={{ background: "#3a76f0" }}>🔒</span>}
              label={t.contact}
              subtitle={t.preview}
              chevron
              onClick={() => setActive(i)}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
