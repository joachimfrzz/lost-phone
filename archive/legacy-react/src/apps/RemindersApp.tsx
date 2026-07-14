import { adaptReminders } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

export function RemindersApp({ data }: { data: unknown }) {
  const lists = adaptReminders(data);

  return (
    <AppShell theme="reminders">
      <LargeTitle title="Rappels" />
      <div className="ui-scroll">
        {lists.map((list, li) => (
          <Group key={li} header={list.name}>
            {list.items.map((item, i) => (
              <Cell
                key={i}
                icon={<span className={`ui-reminder-check ${item.done ? "ui-reminder-check--done" : ""}`} />}
                label={item.title}
                subtitle={item.notes?.slice(0, 80)}
                detail={formatShortDate(item.date)}
              />
            ))}
          </Group>
        ))}
      </div>
    </AppShell>
  );
}
