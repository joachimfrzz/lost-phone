import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

interface Event {
  titre?: string;
  date?: string;
  lieu?: string;
  note?: string;
  rappel?: boolean;
}

export function CalendrierApp({ data }: { data: unknown }) {
  const events = ((data as { evenements?: Event[] })?.evenements ?? [])
    .slice()
    .sort((a, b) => (a.date ?? "").localeCompare(b.date ?? ""));

  return (
    <AppShell theme="calendar">
      <LargeTitle title="Calendrier" />
      <div className="ui-scroll">
        <Group>
          {events.map((e, i) => (
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
            />
          ))}
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
