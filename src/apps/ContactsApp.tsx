import { AppShell } from "../ios/ui/AppShell";
import { Avatar, Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";

interface Contact {
  nom?: string;
  surnom?: string;
  relation?: string;
  note?: string;
}

export function ContactsApp({ data }: { data: unknown }) {
  const contacts = ((data as { fiches?: Contact[] })?.fiches ?? []);
  const grouped = groupByLetter(contacts);

  return (
    <AppShell theme="light">
      <LargeTitle title="Contacts" />
      <div className="ui-scroll">
        {Object.entries(grouped).map(([letter, list]) => (
          <Group key={letter} header={letter}>
            {list.map((c, i) => (
              <Cell
                key={i}
                icon={<Avatar name={c.nom} />}
                label={c.nom}
                subtitle={c.relation ?? c.surnom}
                chevron
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
