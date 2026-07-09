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

type MailFolder = "inbox" | "drafts" | "sent" | "junk" | "trash" | "archive";

const FOLDERS: { id: MailFolder; label: string; icon: string }[] = [
  { id: "inbox", label: "Boîte de réception", icon: "📥" },
  { id: "drafts", label: "Brouillons", icon: "📝" },
  { id: "sent", label: "Envoyés", icon: "📤" },
  { id: "junk", label: "Indésirables", icon: "🚫" },
  { id: "trash", label: "Corbeille", icon: "🗑️" },
  { id: "archive", label: "Archives", icon: "📦" },
];

export function MailApp({ data }: { data: unknown }) {
  const d = data as {
    boite_reception?: Mail[];
    brouillons?: Mail[];
    envoyes?: Mail[];
    indesirables?: Mail[];
    corbeille?: Mail[];
    archives?: Mail[];
  };

  const folders: Record<MailFolder, Mail[]> = {
    inbox: d?.boite_reception ?? [],
    drafts: d?.brouillons ?? [],
    sent: d?.envoyes ?? [],
    junk: d?.indesirables ?? [],
    trash: d?.corbeille ?? [],
    archive: d?.archives ?? [],
  };

  const [view, setView] = useState<"mailboxes" | MailFolder | "compose">("mailboxes");
  const [active, setActive] = useState<number | null>(null);
  const [compose, setCompose] = useState({ to: "", subject: "", body: "" });

  if (view === "compose") {
    return (
      <AppShell theme="mail">
        <NavBar title="Nouveau message" backLabel="Annuler" onBack={() => setView("mailboxes")} />
        <div className="ui-detail" style={{ padding: "12px 20px" }}>
          <label className="ui-mail-compose-row">
            <span>À</span>
            <input value={compose.to} onChange={(e) => setCompose((c) => ({ ...c, to: e.target.value }))} />
          </label>
          <label className="ui-mail-compose-row">
            <span>Objet</span>
            <input value={compose.subject} onChange={(e) => setCompose((c) => ({ ...c, subject: e.target.value }))} />
          </label>
          <textarea
            className="ui-mail-compose-body"
            value={compose.body}
            onChange={(e) => setCompose((c) => ({ ...c, body: e.target.value }))}
            placeholder="Corps du message"
            rows={12}
          />
          <button
            type="button"
            className="ui-mail-send-btn"
            disabled={!compose.to.trim()}
            onClick={() => setView("mailboxes")}
          >
            Envoyer (simulation)
          </button>
        </div>
      </AppShell>
    );
  }

  if (view !== "mailboxes") {
    const mails = folders[view];
    if (active != null && mails[active]) {
      const m = mails[active];
      return (
        <AppShell theme="mail">
          <NavBar title={m.objet ?? "Mail"} backLabel={FOLDERS.find((f) => f.id === view)?.label} onBack={() => setActive(null)} />
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

    const folderLabel = FOLDERS.find((f) => f.id === view)?.label ?? "Mails";
    return (
      <AppShell theme="mail">
        <NavBar title={folderLabel} backLabel="Boîtes" onBack={() => { setView("mailboxes"); setActive(null); }} />
        <div className="ui-scroll">
          <Group>
            {mails.length === 0 ? (
              <Cell label="Aucun message" subtitle="Ce dossier est vide" />
            ) : (
              mails.map((m, i) => (
                <Cell
                  key={i}
                  icon={!m.lu ? <span className="ui-mail-unread-dot" aria-label="Non lu" /> : <span className="ui-mail-read-spacer" />}
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
              ))
            )}
          </Group>
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="mail">
      <header className="ui-nav">
        <div className="ui-nav__side" />
        <h1 className="ui-nav__title">Boîtes</h1>
        <div className="ui-nav__side ui-nav__side--right">
          <button type="button" className="ui-nav__compose" aria-label="Nouveau mail" onClick={() => setView("compose")}>
            <SFCompose />
          </button>
        </div>
      </header>
      <div className="ui-scroll">
        <Group>
          {FOLDERS.map((f) => (
            <Cell
              key={f.id}
              icon={<span style={{ fontSize: 20 }}>{f.icon}</span>}
              label={f.label}
              detail={folders[f.id].length > 0 ? String(folders[f.id].length) : undefined}
              chevron
              onClick={() => setView(f.id)}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
