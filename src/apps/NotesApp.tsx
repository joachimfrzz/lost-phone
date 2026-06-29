import { useState } from "react";
import { adaptNotes } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";

export function NotesApp({ data }: { data: unknown }) {
  const notes = adaptNotes(data);
  const [active, setActive] = useState<number | null>(null);
  const folders = [...new Set(notes.map((n) => n.dossier || "Notes"))];

  if (active != null && notes[active]) {
    const n = notes[active];
    return (
      <AppShell theme="notes">
        <NavBar title={n.dossier ?? "Notes"} backLabel="Notes" onBack={() => setActive(null)} />
        <article className="ui-detail">
          <h2>{n.titre}</h2>
          {n.date_modification && <p className="ui-detail__meta">{n.date_modification}</p>}
          <div className="ui-detail__body">{n.contenu}</div>
        </article>
      </AppShell>
    );
  }

  return (
    <AppShell theme="notes">
      <header className="ui-nav" style={{ background: "#1c1c1e", borderBottom: "none" }}>
        <div className="ui-nav__side" />
        <h1 className="ui-nav__title">Notes</h1>
        <div className="ui-nav__side ui-nav__side--right" />
      </header>
      <div className="ui-scroll">
        {folders.map((folder) => (
          <Group key={folder} header={folder}>
            {notes
              .filter((n) => (n.dossier || "Notes") === folder)
              .map((n, i) => {
                const idx = notes.indexOf(n);
                return (
                  <Cell
                    key={n.id ?? i}
                    label={n.titre}
                    subtitle={n.contenu?.slice(0, 80)}
                    chevron
                    onClick={() => setActive(idx)}
                  />
                );
              })}
          </Group>
        ))}
      </div>
    </AppShell>
  );
}
