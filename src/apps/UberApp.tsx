import { useState } from "react";
import { adaptUber } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

/** Clone Uber **courses** (pas Uber Eats) — onglet Trajets + Activité. */
export function UberApp({ data }: { data: unknown }) {
  const { account, rides } = adaptUber(data);
  const [tab, setTab] = useState<"home" | "activity">("home");
  const [active, setActive] = useState<number | null>(null);
  const addresses = (account?.adresses_enregistrees as Array<{ label?: string; adresse?: string }>) ?? [];

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
      <header className="ui-uber-header">
        <span className="ui-uber-header__logo">Uber</span>
        <span className="ui-uber-header__user">{String(account?.nom ?? "Mathieu G.")}</span>
      </header>

      <div className="ui-uber-tabs">
        <button type="button" className={tab === "home" ? "ui-uber-tabs__active" : ""} onClick={() => setTab("home")}>Trajets</button>
        <button type="button" className={tab === "activity" ? "ui-uber-tabs__active" : ""} onClick={() => setTab("activity")}>Activité</button>
      </div>

      {tab === "home" ? (
        <div className="ui-scroll">
          <div className="ui-uber-map ui-uber-map--home"><div className="ui-uber-car" /></div>
          <div className="ui-uber-search">
            <span>🔍</span>
            <span>Où allez-vous ?</span>
          </div>
          <Group header="Suggestions">
            {addresses.length > 0 ? addresses.map((a, i) => (
              <Cell key={i} icon={<span className="ui-uber-pin">📍</span>} label={a.label} subtitle={a.adresse} chevron />
            )) : (
              <>
                <Cell icon={<span className="ui-uber-pin">🏠</span>} label="Domicile" subtitle="17 rue de la Roquette, Paris" chevron />
                <Cell icon={<span className="ui-uber-pin">💙</span>} label="Hugo" subtitle="Vincennes" chevron />
              </>
            )}
          </Group>
          <Group header="Options">
            <Cell label="UberX" subtitle="Arrivée dans 4 min" detail="12–15 €" />
            <Cell label="Comfort" subtitle="Véhicules récents" detail="18–22 €" />
          </Group>
        </div>
      ) : (
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
      )}
    </AppShell>
  );
}
