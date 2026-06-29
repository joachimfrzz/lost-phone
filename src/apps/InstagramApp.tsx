import { useState } from "react";
import { adaptInstagram } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";

export function InstagramApp({ data }: { data: unknown }) {
  const ig = adaptInstagram(data);
  const [tab, setTab] = useState<"feed" | "dm">("feed");

  return (
    <AppShell theme="instagram">
      <NavBar title="Instagram" />
      <div className="ui-ig-header">
        <div className="ui-ig-avatar" />
        <div>
          <strong>{ig.username}</strong>
          <p style={{ margin: "4px 0", fontSize: 14, color: "#3a3a3c" }}>{ig.bio?.slice(0, 100)}</p>
          <div className="ui-ig-stats">
            <span><strong>{ig.followers}</strong> abonnés</span>
            <span><strong>{ig.following}</strong> abonnements</span>
          </div>
        </div>
      </div>
      <div style={{ display: "flex", borderBottom: "1px solid #efefef" }}>
        <button type="button" style={{ flex: 1, padding: 12, fontWeight: 600, borderBottom: tab === "feed" ? "2px solid #000" : "none" }} onClick={() => setTab("feed")}>Fil</button>
        <button type="button" style={{ flex: 1, padding: 12, fontWeight: 600, borderBottom: tab === "dm" ? "2px solid #000" : "none" }} onClick={() => setTab("dm")}>Messages</button>
      </div>
      <div className="ui-scroll">
        {tab === "feed" ? (
          <div className="ui-ig-grid">
            {ig.feed.map((p, i) => (
              <button key={i} type="button" className="ui-ig-grid__cell" title={p.caption?.slice(0, 80)} />
            ))}
          </div>
        ) : (
          <Group>
            {ig.dms.map((t, i) => (
              <Cell key={i} icon={<span className="ui-avatar">📷</span>} label={t.contact} subtitle={t.preview} chevron />
            ))}
          </Group>
        )}
      </div>
    </AppShell>
  );
}
