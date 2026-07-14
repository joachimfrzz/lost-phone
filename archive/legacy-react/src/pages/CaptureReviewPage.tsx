import { useEffect, useState } from "react";
import { CAPTURE_LABELS, type CaptureId, allCaptureIds } from "../lib/captures";

interface ReportFile {
  file: string;
  id?: CaptureId;
  label?: string;
  score?: number;
  guess?: CaptureId;
}

interface Report {
  files: ReportFile[];
  unassigned: ReportFile[];
}

export function CaptureReviewPage() {
  const [report, setReport] = useState<Report | null>(null);
  const [selections, setSelections] = useState<Record<string, CaptureId>>({});
  const [msg, setMsg] = useState("");

  useEffect(() => {
    fetch(`${import.meta.env.BASE_URL}captures-ios/inbox/report.json`)
      .then((r) => (r.ok ? r.json() : null))
      .then((data: Report | null) => {
        if (!data) return;
        setReport(data);
        const init: Record<string, CaptureId> = {};
        for (const u of data.unassigned) {
          if (u.guess) init[u.file] = u.guess;
        }
        for (const f of data.files) {
          if (f.id && (f.score ?? 0) < 0.32) init[f.file] = f.id;
        }
        setSelections(init);
      })
      .catch(() => setReport(null));
  }, []);

  const pending = report
    ? [...report.unassigned.map((u) => u.file), ...report.files.filter((f) => (f.score ?? 1) < 0.32).map((f) => f.file)]
    : [];

  function exportSelections() {
    const payload = {
      assignments: Object.entries(selections).map(([file, id]) => ({ file, id })),
    };
    const blob = new Blob([JSON.stringify(payload, null, 2)], { type: "application/json" });
    const a = document.createElement("a");
    a.href = URL.createObjectURL(blob);
    a.download = "selections.json";
    a.click();
    setMsg("selections.json téléchargé → mets-le dans inbox/ puis npm run captures:apply");
  }

  if (!report) {
    return (
      <div className="capture-review capture-review--empty">
        <h1>Tri des captures</h1>
        <p>
          1. AirDrop tes PNG dans <code>public/captures-ios/inbox/</code>
          <br />
          2. <code>npm run captures:sort</code>
          <br />
          3. Reviens ici
        </p>
      </div>
    );
  }

  if (pending.length === 0) {
    return (
      <div className="capture-review">
        <h1>Tout est trié ✓</h1>
        <p>Lance <code>npm run captures:status</code> pour vérifier.</p>
      </div>
    );
  }

  return (
    <div className="capture-review">
      <header className="capture-review__head">
        <h1>Valider les captures douteuses</h1>
        <p>{pending.length} image(s) — choisis le bon écran pour chacune.</p>
      </header>

      <div className="capture-review__grid">
        {pending.map((file) => (
          <div key={file} className="capture-review__card">
            <img
              src={`${import.meta.env.BASE_URL}captures-ios/inbox/${file}`}
              alt=""
              className="capture-review__img"
            />
            <p className="capture-review__name">{file}</p>
            <select
              className="capture-review__select"
              value={selections[file] ?? ""}
              onChange={(e) =>
                setSelections((s) => ({ ...s, [file]: e.target.value as CaptureId }))
              }
            >
              <option value="">— Choisir —</option>
              {allCaptureIds().map((id) => (
                <option key={id} value={id}>
                  {CAPTURE_LABELS[id]}
                </option>
              ))}
            </select>
          </div>
        ))}
      </div>

      <footer className="capture-review__foot">
        <button type="button" className="capture-review__btn" onClick={exportSelections}>
          Exporter mes choix
        </button>
        {msg && <p className="capture-review__msg">{msg}</p>}
        <p className="capture-review__help">
          Place <code>selections.json</code> dans <code>inbox/</code> puis{" "}
          <code>npm run captures:apply</code>
        </p>
      </footer>
    </div>
  );
}
