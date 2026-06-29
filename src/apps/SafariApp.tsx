import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";

export function SafariApp({ data }: { data: unknown }) {
  const d = data as {
    onglets_ouverts?: Array<{ titre?: string; url?: string }>;
    historique_recent?: Array<{ titre?: string; url?: string }>;
  };

  return (
    <AppShell theme="safari">
      <LargeTitle title="Safari" />
      <div className="ui-safari-bar">Rechercher ou saisir un site web</div>
      <div className="ui-scroll">
        <Group header="Onglets ouverts">
          {(d?.onglets_ouverts ?? []).map((t, i) => (
            <Cell key={i} label={t.titre} subtitle={t.url} chevron />
          ))}
        </Group>
        <Group header="Historique">
          {(d?.historique_recent ?? []).map((t, i) => (
            <Cell key={i} label={t.titre} subtitle={t.url} chevron />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
