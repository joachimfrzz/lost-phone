import { adaptSpotify } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";

export function SpotifyApp({ data }: { data: unknown }) {
  const spotify = adaptSpotify(data);
  const profile = spotify.profile as { nom?: string; abonnement?: string } | undefined;

  return (
    <AppShell theme="spotify">
      <div className="ui-spotify-hero">
        <LargeTitle title="Bonjour" subtitle={profile?.nom ?? "Mathieu"} />
      </div>
      <div className="ui-scroll">
        <Group header="Playlists">
          {spotify.playlists.slice(0, 12).map((p, i) => (
            <div key={i} className="ui-spotify-playlist">
              <div className="ui-spotify-art" />
              <div>
                <strong>{String(p.nom ?? p.titre ?? "Playlist")}</strong>
                <p style={{ margin: "2px 0 0", fontSize: 13, color: "#b3b3b3" }}>
                  {String(p.description ?? p.nb_morceaux ?? "")}
                </p>
              </div>
            </div>
          ))}
        </Group>
        <Group header="Récemment écouté">
          {spotify.history.slice(0, 8).map((h, i) => (
            <Cell
              key={i}
              label={String(h.titre ?? h.morceau ?? "Morceau")}
              subtitle={String(h.artiste ?? h.album ?? "")}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
