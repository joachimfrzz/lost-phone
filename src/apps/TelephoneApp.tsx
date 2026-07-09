import { useState } from "react";
import { adaptTelephone } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Avatar, Cell, Group } from "../ios/ui/List";
import { LargeTitle, NavBar } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

export function TelephoneApp({ data }: { data: unknown }) {
  const { recents, voicemail } = adaptTelephone(data);
  const [active, setActive] = useState<number | null>(null);
  const [calling, setCalling] = useState(false);

  if (calling && active != null && recents[active]) {
    const r = recents[active];
    return (
      <AppShell theme="phone">
        <div className="ui-phone-call">
          <Avatar name={r.contact} color="#34c759" />
          <h2>{r.contact}</h2>
          <p className="ui-detail__meta">Appel en cours…</p>
          <button type="button" className="ui-phone-call__end" onClick={() => setCalling(false)}>
            Raccrocher
          </button>
        </div>
      </AppShell>
    );
  }

  if (active != null && recents[active]) {
    const r = recents[active];
    return (
      <AppShell theme="phone">
        <NavBar title={r.contact} backLabel="Récents" onBack={() => setActive(null)} />
        <div className="ui-detail" style={{ textAlign: "center", paddingTop: 40 }}>
          <Avatar name={r.contact} color={r.type === "manqué" ? "#ff3b30" : "#34c759"} />
          <h2 style={{ marginTop: 16 }}>{r.contact}</h2>
          <p className="ui-detail__meta">{r.type} · {formatShortDate(r.date)}</p>
          {r.duration && <p className="ui-detail__meta">Durée : {r.duration}s</p>}
          <div className="ui-phone-actions">
            <button type="button" onClick={() => setCalling(true)}>📞 Appeler</button>
            <button type="button">💬 Message</button>
          </div>
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="phone">
      <LargeTitle title="Récents" />
      <div className="ui-scroll">
        <Group>
          {recents.map((r, i) => (
            <Cell
              key={i}
              icon={<Avatar name={r.contact} color={r.type === "manqué" ? "#ff3b30" : "#34c759"} />}
              label={r.contact}
              subtitle={r.type}
              detail={r.duration ? `${r.duration}s` : formatShortDate(r.date)}
              chevron
              onClick={() => setActive(i)}
            />
          ))}
        </Group>
        {voicemail.length > 0 && (
          <Group header="Messagerie vocale">
            {voicemail.map((v, i) => (
              <Cell
                key={i}
                label={String((v as { contact?: string }).contact ?? "Message")}
                subtitle={String((v as { extrait?: string }).extrait ?? "")}
                detail={formatShortDate((v as { date?: string }).date)}
              />
            ))}
          </Group>
        )}
      </div>
    </AppShell>
  );
}
