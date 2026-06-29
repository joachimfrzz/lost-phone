import { useState } from "react";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";
import { SFCompose } from "../ios/ui/SFSymbols";
import { formatShortDate } from "../ios/ui/utils";

interface Mail {
  de?: string;
  objet?: string;
  extrait?: string;
  date?: string;
  lu?: boolean;
  corps?: string;
}

export function MailApp({ data }: { data: unknown }) {
  const mails = ((data as { boite_reception?: Mail[] })?.boite_reception ?? []);
  const [active, setActive] = useState<number | null>(null);

  if (active != null && mails[active]) {
    const m = mails[active];
    return (
      <AppShell theme="mail">
        <NavBar title={m.objet ?? "Mail"} backLabel="Boîtes" onBack={() => setActive(null)} />
        <article className="ui-detail">
          <div className="ui-mail-from">
            <span className="ui-avatar">{m.de?.charAt(0)}</span>
            <div>
              <strong>{m.de}</strong>
              <p className="ui-detail__meta">À : moi</p>
            </div>
          </div>
          <p className="ui-detail__meta">{m.date}</p>
          <div className="ui-detail__body">{m.corps ?? m.extrait}</div>
        </article>
      </AppShell>
    );
  }

  return (
    <AppShell theme="mail">
      <header className="ui-nav">
        <div className="ui-nav__side" />
        <h1 className="ui-nav__title">Boîtes</h1>
        <div className="ui-nav__side ui-nav__side--right">
          <button type="button" className="ui-nav__compose" aria-label="Nouveau mail">
            <SFCompose />
          </button>
        </div>
      </header>
      <p className="ui-mail-large-title">Boîte de réception</p>
      <div className="ui-scroll">
        <Group>
          {mails.map((m, i) => (
            <Cell
              key={i}
              icon={
                !m.lu ? (
                  <span className="ui-mail-unread-dot" aria-label="Non lu" />
                ) : (
                  <span className="ui-mail-read-spacer" />
                )
              }
              label={m.de}
              subtitle={
                <>
                  <strong className={m.lu ? "" : "ui-mail-subject-bold"}>{m.objet}</strong>
                  <span className="ui-mail-preview"> — {m.extrait?.slice(0, 70)}</span>
                </>
              }
              detail={formatShortDate(m.date)}
              onClick={() => setActive(i)}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
