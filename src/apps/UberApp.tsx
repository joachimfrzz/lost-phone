import { useState } from "react";
import { adaptUber } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle, NavBar } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

export function UberApp({ data }: { data: unknown }) {
  const { rides } = adaptUber(data);
  const [active, setActive] = useState<number | null>(null);

  if (active != null && rides[active]) {
    const r = rides[active];
    return (
      <AppShell theme="uber">
        <NavBar title="Course" backLabel="Uber" onBack={() => setActive(null)} />
        <div className="ui-uber-map"><div className="ui-uber-route" /></div>
        <div className="ui-detail">
          <h2>{r.price}</h2>
          <p className="ui-detail__meta">{formatShortDate(r.date)} · {r.duration}</p>
          <p><strong>Départ</strong><br />{r.pickup}</p>
          <p style={{ marginTop: 12 }}><strong>Arrivée</strong><br />{r.dropoff}</p>
          {r.driver && <p className="ui-detail__meta" style={{ marginTop: 16 }}>Chauffeur : {r.driver}</p>}
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="uber">
      <LargeTitle title="Activité" />
      <div className="ui-scroll">
        <Group>
          {rides.map((r, i) => (
            <Cell
              key={r.id ?? i}
              label={`${r.pickup?.split(",")[0] ?? "Départ"} → ${r.dropoff?.split(",")[0] ?? "Arrivée"}`}
              subtitle={`${r.driver} · ${formatShortDate(r.date)}`}
              detail={r.price}
              chevron
              onClick={() => setActive(i)}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
