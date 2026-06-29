import { adaptTelephone } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Avatar, Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

export function TelephoneApp({ data }: { data: unknown }) {
  const { recents, voicemail } = adaptTelephone(data);

  return (
    <AppShell theme="phone">
      <LargeTitle title="Récents" />
      <div className="ui-scroll">
        <Group>
          {recents.map((r, i) => (
            <Cell
              key={i}
              icon={<Avatar name={r.contact} color={r.type === "manqué" ? "#ff3b30" : "#34c759"} />}
              label={r.contact}
              subtitle={r.type}
              detail={r.duration ? `${r.duration}s` : formatShortDate(r.date)}
            />
          ))}
        </Group>
        {voicemail.length > 0 && (
          <Group header="Messagerie vocale">
            {voicemail.map((v, i) => (
              <Cell
                key={i}
                label={String((v as { contact?: string }).contact ?? "Message")}
                subtitle={String((v as { extrait?: string }).extrait ?? "")}
                detail={formatShortDate((v as { date?: string }).date)}
              />
            ))}
          </Group>
        )}
      </div>
    </AppShell>
  );
}
