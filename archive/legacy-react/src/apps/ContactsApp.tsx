import { useState } from "react";
import { AppShell } from "../ios/ui/AppShell";
import { Avatar, Cell, Group } from "../ios/ui/List";
import { LargeTitle, NavBar } from "../ios/ui/NavBar";

interface Contact {
  nom?: string;
  surnom?: string;
  relation?: string;
  note?: string;
  telephone?: string;
  email?: string;
}

interface OwnerCard {
  nom?: string;
  telephone?: string;
  email?: string;
  adresse?: string;
}

export function ContactsApp({ data }: { data: unknown }) {
  const d = data as { fiches?: Contact[]; proprietaire?: OwnerCard };
  const contacts = d?.fiches ?? [];
  const [active, setActive] = useState<Contact | OwnerCard | null>(null);
  const grouped = groupByLetter(contacts);

  if (active) {
    const name = active.nom ?? "Contact";
    return (
      <AppShell theme="light">
        <NavBar title={name} backLabel="Contacts" onBack={() => setActive(null)} />
        <div className="ui-detail" style={{ textAlign: "center", paddingTop: 32 }}>
          <Avatar name={name} />
          <h2 style={{ marginTop: 16 }}>{name}</h2>
          {"relation" in active && active.relation && <p className="ui-detail__meta">{active.relation}</p>}
          {"surnom" in active && active.surnom && <p className="ui-detail__meta">{active.surnom}</p>}
          {active.telephone && <p><strong>Tél.</strong> {active.telephone}</p>}
          {active.email && <p><strong>Email</strong> {active.email}</p>}
          {"adresse" in active && active.adresse && <p><strong>Adresse</strong> {active.adresse}</p>}
          {"note" in active && active.note && <p className="ui-detail__body">{active.note}</p>}
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="light">
      <LargeTitle title="Contacts" />
      <div className="ui-scroll">
        {d?.proprietaire && (
          <Group header="Ma carte">
            <Cell
              icon={<Avatar name={d.proprietaire.nom} color="#007aff" />}
              label={d.proprietaire.nom ?? "Moi"}
              subtitle={d.proprietaire.telephone ?? d.proprietaire.email}
              chevron
              onClick={() => setActive(d.proprietaire!)}
            />
          </Group>
        )}
        {Object.entries(grouped).map(([letter, list]) => (
          <Group key={letter} header={letter}>
            {list.map((c, i) => (
              <Cell
                key={i}
                icon={<Avatar name={c.nom} />}
                label={c.nom}
                subtitle={c.relation ?? c.surnom}
                chevron
                onClick={() => setActive(c)}
              />
            ))}
          </Group>
        ))}
      </div>
    </AppShell>
  );
}

function groupByLetter(contacts: Contact[]): Record<string, Contact[]> {
  const out: Record<string, Contact[]> = {};
  for (const c of contacts) {
    const letter = (c.nom?.charAt(0) ?? "#").toUpperCase();
    (out[letter] ??= []).push(c);
  }
  return out;
}
