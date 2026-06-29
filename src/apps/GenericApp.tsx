import { AppShell } from "../ios/ui/AppShell";
import { LargeTitle } from "../ios/ui/NavBar";
import { usePhone } from "../runtime/PhoneProvider";

export function GenericApp() {
  const { activeApp, getAppData } = usePhone();
  const data = activeApp ? getAppData(activeApp) : null;

  return (
    <AppShell theme="light">
      <LargeTitle title={activeApp ?? "App"} />
      <pre className="ui-detail" style={{ fontSize: 11, fontFamily: "ui-monospace, monospace", whiteSpace: "pre-wrap" }}>
        {JSON.stringify(data, null, 2)}
      </pre>
    </AppShell>
  );
}
