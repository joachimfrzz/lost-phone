import { adaptMaps } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

export function MapsApp({ data }: { data: unknown }) {
  const maps = adaptMaps(data);

  return (
    <AppShell theme="maps">
      <LargeTitle title="Plans" />
      <div className="ui-safari-bar">Rechercher un lieu</div>
      <div className="ui-scroll">
        <Group header="Adresses enregistrées">
          {maps.places.map((p, i) => (
            <Cell
              key={i}
              icon={<span className="ui-map-pin" style={{ transform: "rotate(-45deg) scale(0.6)" }} />}
              label={String(p.label ?? p.nom ?? "Adresse")}
              subtitle={String(p.adresse ?? p.address ?? "")}
              chevron
            />
          ))}
        </Group>
        <Group header="Itinéraires sauvegardés">
          {maps.routes.map((r, i) => (
            <Cell
              key={i}
              label={String(r.nom ?? r.titre ?? "Itinéraire")}
              subtitle={String(r.description ?? r.note ?? "")}
              chevron
            />
          ))}
        </Group>
        <Group header="Historique">
          {maps.history.map((h, i) => (
            <Cell
              key={i}
              label={String(h.destination ?? h.arrivee ?? h.lieu ?? "Trajet")}
              subtitle={String(h.mode ?? h.note_interne ?? "").slice(0, 80)}
              detail={formatShortDate(h.date as string)}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
