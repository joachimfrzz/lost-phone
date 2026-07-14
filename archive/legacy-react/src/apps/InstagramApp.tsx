import { useState } from "react";
import { adaptInstagram } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { ChatThread } from "../ios/ui/ChatThread";
import { Cell, Group } from "../ios/ui/List";
import { NavBar } from "../ios/ui/NavBar";
import { formatShortDate } from "../ios/ui/utils";

type Tab = "home" | "search" | "profile" | "dm";

export function InstagramApp({ data }: { data: unknown }) {
  const ig = adaptInstagram(data);
  const [tab, setTab] = useState<Tab>("home");
  const [activePost, setActivePost] = useState<number | null>(null);
  const [activeDm, setActiveDm] = useState<number | null>(null);
  const [activeStory, setActiveStory] = useState<number | null>(null);
  const [liked, setLiked] = useState<Set<number>>(new Set());

  const stories = ig.stories.length > 0
    ? ig.stories
    : [{ username: ig.username, seen: false }, { username: "pabordeaux", seen: true }];

  if (activeStory != null && stories[activeStory]) {
    const s = stories[activeStory];
    return (
      <AppShell theme="instagram">
        <NavBar title={s.username} backLabel="Stories" onBack={() => setActiveStory(null)} />
        <div className="ui-ig-story-view">
          <div className="ui-ig-story-view__media" />
          <p>Story de @{s.username}</p>
        </div>
      </AppShell>
    );
  }

  if (activeDm != null && ig.dms[activeDm]) {
    const t = ig.dms[activeDm];
    return (
      <AppShell theme="instagram">
        <NavBar title={t.contact} backLabel="Messages" onBack={() => setActiveDm(null)} />
        <ChatThread
          theme="messages"
          scrollToEnd
          messages={t.messages.map((m) => ({ id: m.id, text: m.text, outgoing: m.outgoing, time: m.time }))}
        />
      </AppShell>
    );
  }

  if (activePost != null && ig.feed[activePost]) {
    const p = ig.feed[activePost];
    const isLiked = liked.has(activePost);
    return (
      <AppShell theme="instagram">
        <NavBar title="Publication" backLabel="Retour" onBack={() => setActivePost(null)} />
        <article className="ui-detail">
          <div className="ui-ig-post-preview" />
          <p style={{ margin: "12px 0" }}>{p.caption}</p>
          <p className="ui-detail__meta">{formatShortDate(p.date)}</p>
          <div className="ui-ig-post-actions">
            <button type="button" onClick={() => setLiked((s) => new Set(s).add(activePost))}>
              {isLiked ? "❤️" : "🤍"} {p.likes + (isLiked ? 1 : 0)} j'aime
            </button>
            <span>💬 {p.comments} commentaires</span>
          </div>
          {p.comments > 0 && (
            <Group header="Commentaires">
              <Cell label="pabordeaux" subtitle="Grave 👌 bon courage pour le projet" />
              {p.comments > 1 && <Cell label="vincent.morel" subtitle="Trop stylé 🔥" />}
            </Group>
          )}
        </article>
      </AppShell>
    );
  }

  const grid = (onSelect: (i: number) => void) => (
    <div className="ui-ig-grid">
      {ig.feed.map((p, i) => (
        <button key={i} type="button" className="ui-ig-grid__cell" title={p.caption?.slice(0, 80)} onClick={() => onSelect(i)} />
      ))}
    </div>
  );

  return (
    <AppShell theme="instagram">
      <NavBar title="Instagram" />
      {(tab === "home" || tab === "profile") && (
        <>
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
          {tab === "home" && (
            <div className="ui-ig-stories">
              {stories.map((s, i) => (
                <button key={i} type="button" className={`ui-ig-story ${s.seen ? "ui-ig-story--seen" : ""}`} onClick={() => setActiveStory(i)}>
                  <span className="ui-ig-story__ring">
                    <span className="ui-ig-story__avatar">{s.username.charAt(0)}</span>
                  </span>
                  <span className="ui-ig-story__name">{s.username.split(".")[0]}</span>
                </button>
              ))}
            </div>
          )}
        </>
      )}
      <div className="ui-scroll">
        {tab === "home" && grid(setActivePost)}
        {tab === "search" && grid(setActivePost)}
        {tab === "profile" && grid(setActivePost)}
        {tab === "dm" && (
          <Group>
            {ig.dms.map((t, i) => (
              <Cell key={i} icon={<span className="ui-avatar ui-avatar--ig-dm">✉️</span>} label={t.contact} subtitle={t.preview} chevron onClick={() => setActiveDm(i)} />
            ))}
          </Group>
        )}
      </div>
      <nav className="ui-ig-dock">
        <button type="button" className={tab === "home" ? "ui-ig-dock__on" : ""} onClick={() => setTab("home")} aria-label="Accueil">⌂</button>
        <button type="button" className={tab === "search" ? "ui-ig-dock__on" : ""} onClick={() => setTab("search")} aria-label="Recherche">🔍</button>
        <button type="button" className="ui-ig-dock__disabled" disabled aria-label="Nouveau post désactivé">＋</button>
        <button type="button" className={tab === "dm" ? "ui-ig-dock__on" : ""} onClick={() => setTab("dm")} aria-label="Messages">✉️</button>
        <button type="button" className={tab === "profile" ? "ui-ig-dock__on" : ""} onClick={() => setTab("profile")} aria-label="Profil">👤</button>
      </nav>
    </AppShell>
  );
}
