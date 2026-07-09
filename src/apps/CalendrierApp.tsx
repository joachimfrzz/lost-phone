import { useState } from "react";
import { usePhone } from "../runtime/PhoneProvider";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle, NavBar } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

interface Event {
  titre?: string;
  date?: string;
  lieu?: string;
  note?: string;
  rappel?: boolean;
}

function storyMonthKey(dateVerrou?: string): string | null {
  if (!dateVerrou) return null;
  const m = dateVerrou.match(/(\d{1,2})\s+(janvier|février|fevrier|mars|avril|mai|juin|juillet|août|aout|septembre|octobre|novembre|décembre|decembre)/i);
  if (!m) return null;
  const months: Record<string, string> = {
    janvier: "01", février: "02", fevrier: "02", mars: "03", avril: "04", mai: "05", juin: "06",
    juillet: "07", août: "08", aout: "08", septembre: "09", octobre: "10", novembre: "11", décembre: "12", decembre: "12",
  };
  const month = months[m[2].toLowerCase()];
  if (!month) return null;
  const year = new Date().getFullYear();
  return `${year}-${month}`;
}

function eventMonthKey(date?: string): string | null {
  if (!date) return null;
  try {
    const d = new Date(date);
    if (Number.isNaN(d.getTime())) return null;
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}`;
  } catch {
    return null;
  }
}

export function CalendrierApp({ data }: { data: unknown }) {
  const { lpsp } = usePhone();
  const [active, setActive] = useState<number | null>(null);
  const monthKey = storyMonthKey(lpsp.content.envelope.date_verrou);

  const events = ((data as { evenements?: Event[] })?.evenements ?? [])
    .filter((e) => !monthKey || eventMonthKey(e.date) === monthKey)
    .slice()
    .sort((a, b) => (a.date ?? "").localeCompare(b.date ?? ""));

  if (active != null && events[active]) {
    const e = events[active];
    return (
      <AppShell theme="calendar">
        <NavBar title={e.titre ?? "Événement"} backLabel="Calendrier" onBack={() => setActive(null)} />
        <div className="ui-detail">
          <p className="ui-detail__meta">{formatShortDate(e.date)}</p>
          {e.lieu && <p><strong>Lieu</strong><br />{e.lieu}</p>}
          {e.note && (
            <div style={{ marginTop: 16 }}>
              <strong>Notes</strong>
              <p className="ui-detail__body">{e.note}</p>
            </div>
          )}
          {e.rappel && <p className="ui-detail__meta" style={{ marginTop: 12 }}>Rappel activé</p>}
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="calendar">
      <LargeTitle title="Calendrier" />
      {monthKey && (
        <p style={{ margin: "0 20px 8px", fontSize: 15, color: "#8e8e93" }}>
          {lpsp.content.envelope.date_verrou} · {lpsp.content.envelope.heure_verrou}
        </p>
      )}
      <div className="ui-scroll">
        <Group>
          {events.length === 0 ? (
            <Cell label="Aucun événement ce mois-ci" />
          ) : (
            events.map((e, i) => (
              <Cell
                key={i}
                icon={
                  <span style={{ textAlign: "center", minWidth: 36 }}>
                    <span style={{ display: "block", fontSize: 20, fontWeight: 300, color: "#ff3b30" }}>
                      {dayNum(e.date)}
                    </span>
                    <span style={{ fontSize: 10, fontWeight: 600, color: "#ff3b30", textTransform: "uppercase" }}>
                      {monthShort(e.date)}
                    </span>
                  </span>
                }
                label={e.titre}
                subtitle={[e.lieu, e.note?.slice(0, 60)].filter(Boolean).join(" · ")}
                detail={formatShortDate(e.date)}
                chevron
                onClick={() => setActive(i)}
              />
            ))
          )}
        </Group>
      </div>
    </AppShell>
  );
}

function dayNum(d?: string) {
  if (!d) return "—";
  try { return new Date(d).getDate(); } catch { return "—"; }
}

function monthShort(d?: string) {
  if (!d) return "";
  try { return new Date(d).toLocaleDateString("fr-FR", { month: "short" }); } catch { return ""; }
}
