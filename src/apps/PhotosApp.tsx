import { useState } from "react";
import { photoBackground } from "../lib/photoVisual";
import { AppShell } from "../ios/ui/AppShell";
import { NavBar } from "../ios/ui/NavBar";
import { SFAlbums, SFPhotos } from "../ios/ui/SFSymbols";
import { TabBar, type TabItem } from "../ios/ui/TabBar";

interface Photo {
  titre?: string;
  description?: string;
  date?: string;
  lieu?: string;
}

const TABS: TabItem[] = [
  { id: "library", label: "Bibliothèque", icon: <SFPhotos /> },
  { id: "albums", label: "Albums", icon: <SFAlbums /> },
];

export function PhotosApp({ data }: { data: unknown }) {
  const d = data as { recents?: Photo[]; albums?: Array<{ nom?: string; photos?: Photo[] }> };
  const recents = d?.recents ?? [];
  const [tab, setTab] = useState("library");
  const [active, setActive] = useState<Photo | null>(null);

  if (active) {
    const bg = photoBackground(active.description, active.titre);
    return (
      <AppShell theme="photos">
        <NavBar title={active.titre ?? "Photo"} backLabel="Bibliothèque" onBack={() => setActive(null)} />
        <div className="ui-scroll">
          <div
            className="ui-photo-detail"
            style={{ background: bg, minHeight: 280, backgroundSize: "cover", backgroundPosition: "center" }}
          />
          <div className="ui-detail" style={{ background: "#000", color: "#fff" }}>
            <h2>{active.titre ?? "Photo"}</h2>
            {active.lieu && <p className="ui-detail__meta">{active.lieu}</p>}
            {active.date && <p className="ui-detail__meta">{active.date}</p>}
            <p className="ui-detail__body">{active.description}</p>
          </div>
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell theme="photos">
      <header className="ui-nav" style={{ background: "rgba(0,0,0,0.85)", borderBottom: "none" }}>
        <div className="ui-nav__side" />
        <h1 className="ui-nav__title">Photos</h1>
        <div className="ui-nav__side ui-nav__side--right">
          <span style={{ color: "#0a84ff", fontSize: 17 }}>Sélectionner</span>
        </div>
      </header>
      <p style={{ margin: "8px 20px", fontSize: 22, fontWeight: 700, color: "#fff" }}>Bibliothèque</p>
      <p style={{ margin: "0 20px 12px", fontSize: 15, color: "#8e8e93" }}>{recents.length} éléments</p>
      <div className="ui-scroll">
        {tab === "library" ? (
          <div className="ui-photo-grid">
            {recents.map((p, i) => (
              <button
                key={i}
                type="button"
                className="ui-photo-thumb"
                style={{ background: photoBackground(p.description, p.titre) }}
                onClick={() => setActive(p)}
                aria-label={p.titre}
              />
            ))}
          </div>
        ) : (
          (d?.albums ?? []).map((a, i) => (
            <div key={i} className="ui-cell" style={{ padding: "12px 20px", color: "#fff" }}>
              <span className="ui-cell__label">{a.nom}</span>
              <span className="ui-cell__detail">{a.photos?.length ?? 0}</span>
            </div>
          ))
        )}
      </div>
      <TabBar tabs={TABS} active={tab} onChange={setTab} />
    </AppShell>
  );
}
