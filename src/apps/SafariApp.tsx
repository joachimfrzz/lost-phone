import { useState } from "react";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";

export function SafariApp({ data }: { data: unknown }) {
  const d = data as {
    page_accueil?: string;
    onglets_ouverts?: Array<{ titre?: string; url?: string }>;
    historique_recent?: Array<{ titre?: string; url?: string }>;
    signets?: Array<{ titre?: string; url?: string }>;
  };

  const [activeTab, setActiveTab] = useState<{ titre?: string; url?: string } | null>(null);
  const homepage = d?.page_accueil ?? "https://www.google.com";

  if (activeTab) {
    return (
      <AppShell theme="safari">
        <NavBar title={activeTab.titre ?? "Safari"} backLabel="Safari" onBack={() => setActiveTab(null)} />
        <div className="ui-safari-bar">{activeTab.url}</div>
        <div className="ui-detail">
          <p>Page web simulée — contenu narratif dans l'histoire LPSP.</p>
          <p className="ui-detail__meta">{activeTab.url}</p>
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="safari">
      <NavBar title="Safari" />
      <button type="button" className="ui-safari-bar" onClick={() => setActiveTab({ titre: "Google", url: homepage })}>
        google.com
      </button>
      <div className="ui-scroll">
        <Group header="Favoris">
          <Cell icon={<span>🌐</span>} label="Google" subtitle={homepage} chevron onClick={() => setActiveTab({ titre: "Google", url: homepage })} />
        </Group>
        <Group header="Onglets ouverts">
          {(d?.onglets_ouverts ?? []).map((t, i) => (
            <Cell key={i} label={t.titre} subtitle={t.url} chevron onClick={() => setActiveTab(t)} />
          ))}
        </Group>
        <Group header="Signets">
          {(d?.signets ?? []).map((t, i) => (
            <Cell key={i} label={t.titre} subtitle={t.url} chevron onClick={() => setActiveTab(t)} />
          ))}
        </Group>
        <Group header="Historique">
          {(d?.historique_recent ?? []).map((t, i) => (
            <Cell key={i} label={t.titre} subtitle={t.url} chevron onClick={() => setActiveTab(t)} />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
