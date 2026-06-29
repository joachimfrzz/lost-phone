import { useCallback, useEffect, useMemo, useState } from "react";
import { CAPTURE_PATHS, type CaptureId } from "../lib/captures";
import { CAPTURE_STEPS, totalSlotCount } from "../lib/captureSlots";
import "./capture-upload.css";

type SlotStatus = Record<string, boolean>;

type WallpaperStatus = { ok: boolean; path?: string };

export function CaptureUploadPage() {
  const [status, setStatus] = useState<SlotStatus>({});
  const [done, setDone] = useState(0);
  const [wallpaper, setWallpaper] = useState<WallpaperStatus>({ ok: false });
  const [uploading, setUploading] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [openStep, setOpenStep] = useState("noyau");
  const [lanHint, setLanHint] = useState("");

  const refresh = useCallback(async () => {
    try {
      const res = await fetch("/api/captures/status");
      if (!res.ok) return;
      const data = (await res.json()) as {
        status: SlotStatus;
        done: number;
        total: number;
        wallpaper?: WallpaperStatus;
      };
      setStatus(data.status);
      setDone(data.done);
      if (data.wallpaper) setWallpaper(data.wallpaper);
    } catch {
      /* dev server off */
    }
  }, []);

  useEffect(() => {
    refresh();
    const id = window.setInterval(refresh, 4000);
    return () => window.clearInterval(id);
  }, [refresh]);

  useEffect(() => {
    const host = window.location.hostname;
    const port = window.location.port || "5174";
    if (host === "localhost" || host === "127.0.0.1") {
      setLanHint(
        "Sur ton iPhone : connecte-toi au même Wi-Fi que ce PC, puis ouvre l’IP locale de ce PC (ex. http://192.168.1.xx:" +
          port +
          "/captures-upload). Demande « ipconfig » sur le PC si besoin.",
      );
    } else {
      setLanHint("Tu es connecté depuis le réseau — parfait pour envoyer depuis l’iPhone.");
    }
  }, []);

  const total = totalSlotCount();
  const progress = total ? Math.round((done / total) * 100) : 0;

  async function uploadWallpaper(file: File) {
    setError(null);
    setUploading("wallpaper");
    try {
      const data = await new Promise<string>((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => {
          const result = reader.result as string;
          const base64 = result.split(",")[1];
          if (!base64) reject(new Error("Lecture fichier échouée"));
          else resolve(base64);
        };
        reader.onerror = () => reject(reader.error);
        reader.readAsDataURL(file);
      });

      const ext = file.name.split(".").pop()?.toLowerCase() ?? "png";
      const res = await fetch("/api/assets/wallpaper/upload", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ data, ext }),
      });
      const json = (await res.json()) as { error?: string; path?: string };
      if (!res.ok) throw new Error(json.error ?? "Upload échoué");
      setWallpaper({ ok: true, path: json.path });
    } catch (e) {
      setError(e instanceof Error ? e.message : "Erreur upload");
    } finally {
      setUploading(null);
    }
  }

  async function uploadFile(id: CaptureId, file: File) {
    setError(null);
    setUploading(id);
    try {
      const data = await new Promise<string>((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => {
          const result = reader.result as string;
          const base64 = result.split(",")[1];
          if (!base64) reject(new Error("Lecture fichier échouée"));
          else resolve(base64);
        };
        reader.onerror = () => reject(reader.error);
        reader.readAsDataURL(file);
      });

      const ext = file.name.split(".").pop()?.toLowerCase() ?? "png";
      const res = await fetch("/api/captures/upload", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id, data, ext }),
      });
      const json = (await res.json()) as { error?: string };
      if (!res.ok) throw new Error(json.error ?? "Upload échoué");
      await refresh();
    } catch (e) {
      setError(e instanceof Error ? e.message : "Erreur upload");
    } finally {
      setUploading(null);
    }
  }

  async function clearAll() {
    if (!window.confirm("Supprimer toutes les captures ?")) return;
    await fetch("/api/captures/clear", { method: "POST" });
    await refresh();
  }

  const stepsWithProgress = useMemo(
    () =>
      CAPTURE_STEPS.map((step) => {
        const filled = step.slots.filter((s) => status[s.id]).length;
        return { ...step, filled, total: step.slots.length };
      }),
    [status],
  );

  return (
    <div className="cap-up">
      <header className="cap-up__head">
        <h1>Envoi captures iOS</h1>
        <p className="cap-up__lead">
          iPhone → Safari → cette page. Chaque capture va directement au bon dossier. Le contenu
          affiché n’a pas d’importance — seul le design iOS compte.
        </p>
        <div className="cap-up__network">
          <strong>📱 iPhone + RDP iPad</strong>
          <p>{lanHint}</p>
          <p className="cap-up__url">
            URL : <code>{window.location.origin}/captures-upload</code>
          </p>
        </div>
        <div className="cap-up__progress">
          <div className="cap-up__progress-bar" style={{ width: `${progress}%` }} />
          <span>
            {done}/{total} ({progress}%)
          </span>
        </div>
      </header>

      {error && <p className="cap-up__error">{error}</p>}

      <section className="cap-up__wallpaper">
        <h2>Fond d&apos;écran (calibration)</h2>
        <p>
          Envoie la photo depuis <strong>Photos</strong> — pas besoin de RDP ni de câble. Idéal :
          capture depuis Réglages → Fond d&apos;écran → Personnaliser.
        </p>
        <label
          className={`cap-up__slot cap-up__slot--wallpaper${wallpaper.ok ? " cap-up__slot--ok" : ""}${uploading === "wallpaper" ? " cap-up__slot--busy" : ""}`}
        >
          <input
            type="file"
            accept="image/*"
            disabled={uploading === "wallpaper"}
            onChange={(e) => {
              const f = e.target.files?.[0];
              if (f) uploadWallpaper(f);
              e.target.value = "";
            }}
          />
          <span className="cap-up__slot-icon">{wallpaper.ok ? "✓" : "+"}</span>
          <span className="cap-up__slot-text">
            <strong>{wallpaper.ok ? "Fond d'écran reçu" : "Choisir la photo"}</strong>
            <small>Photos récentes → ta capture ou image</small>
            {wallpaper.path && <small className="cap-up__slot-path">{wallpaper.path}</small>}
          </span>
        </label>
      </section>

      <div className="cap-up__actions">
        <button type="button" className="cap-up__btn cap-up__btn--ghost" onClick={() => refresh()}>
          Actualiser
        </button>
        <button type="button" className="cap-up__btn cap-up__btn--danger" onClick={clearAll}>
          Tout supprimer
        </button>
      </div>

      <ol className="cap-up__steps">
        {stepsWithProgress.map((step) => {
          const complete = step.filled === step.total;
          const isOpen = openStep === step.id;
          return (
            <li key={step.id} className={`cap-up__step${complete ? " cap-up__step--done" : ""}`}>
              <button
                type="button"
                className="cap-up__step-head"
                onClick={() => setOpenStep(isOpen ? "" : step.id)}
              >
                <span className="cap-up__step-title">
                  {complete ? "✓ " : ""}
                  {step.title}
                </span>
                <span className="cap-up__step-count">
                  {step.filled}/{step.total}
                </span>
              </button>

              {isOpen && (
                <div className="cap-up__slots">
                  {step.description && <p className="cap-up__step-desc">{step.description}</p>}
                  {step.slots.map((slot) => {
                    const ok = status[slot.id];
                    const busy = uploading === slot.id;
                    return (
                      <label
                        key={slot.id}
                        className={`cap-up__slot${ok ? " cap-up__slot--ok" : ""}${busy ? " cap-up__slot--busy" : ""}`}
                      >
                        <input
                          type="file"
                          accept="image/*"
                          disabled={busy}
                          onChange={(e) => {
                            const f = e.target.files?.[0];
                            if (f) uploadFile(slot.id, f);
                            e.target.value = "";
                          }}
                        />
                        <span className="cap-up__slot-icon">{ok ? "✓" : "+"}</span>
                        <span className="cap-up__slot-text">
                          <strong>{slot.label}</strong>
                          <small>{slot.hint}</small>
                          <small className="cap-up__slot-path">{CAPTURE_PATHS[slot.id]}</small>
                        </span>
                      </label>
                    );
                  })}
                </div>
              )}
            </li>
          );
        })}
      </ol>

      <footer className="cap-up__foot">
        <p>
          Astuce iPhone : capture écran (Power + Volume), puis ici « + » → Photos récentes. Pas
          besoin de RDP ni de dossier inbox.
        </p>
      </footer>
    </div>
  );
}
