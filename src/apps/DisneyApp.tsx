import { useState } from "react";
import { adaptDisney } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";

export function DisneyApp({ data }: { data: unknown }) {
  const disney = adaptDisney(data);
  const [profile, setProfile] = useState<Record<string, unknown> | null>(null);

  if (!profile) {
    return (
      <AppShell theme="disney">
        <NavBar title="Qui regarde ?" transparent />
        <div className="ui-disney-profiles">
          {disney.profiles.map((p, i) => (
            <button key={i} type="button" className="ui-disney-profile" onClick={() => setProfile(p)}>
              <div className="ui-disney-profile__avatar" />
              <span>{String(p.nom ?? p.prenom ?? `Profil ${i + 1}`)}</span>
            </button>
          ))}
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="disney">
      <NavBar title="Netflix" backLabel="Profils" onBack={() => setProfile(null)} />
      <div className="ui-scroll" style={{ paddingTop: 8 }}>
        <Group header="Continuer à regarder">
          {disney.continueWatching.map((item, i) => (
            <Cell
              key={i}
              label={String(item.titre ?? item.serie ?? "Titre")}
              subtitle={String(item.progression ?? item.episode ?? "")}
              chevron
            />
          ))}
        </Group>
        <Group header="Catalogue">
          {disney.favorites.slice(0, 10).map((item, i) => (
            <Cell key={i} label={String(item.titre ?? "Film")} subtitle={String(item.genre ?? "")} chevron />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
