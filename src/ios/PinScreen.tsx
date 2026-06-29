import { useEffect, useState } from "react";
import { BackspaceIcon } from "../components/ios/StatusIcons";
import { usePhone } from "../runtime/PhoneProvider";
import { HomeIndicator } from "./IphoneShell";

const ROWS: Array<Array<{ digit: string; sub?: string } | "delete" | null>> = [
  [{ digit: "1" }, { digit: "2", sub: "ABC" }, { digit: "3", sub: "DEF" }],
  [{ digit: "4", sub: "GHI" }, { digit: "5", sub: "JKL" }, { digit: "6", sub: "MNO" }],
  [{ digit: "7", sub: "PQRS" }, { digit: "8", sub: "TUV" }, { digit: "9", sub: "WXYZ" }],
  [null, { digit: "0" }, "delete"],
];

export function PinScreen() {
  const { submitPin, pinError, cancelPin } = usePhone();
  const [digits, setDigits] = useState("");
  const [shake, setShake] = useState(false);

  useEffect(() => {
    if (pinError) {
      setShake(true);
      setDigits("");
      const t = window.setTimeout(() => setShake(false), 500);
      return () => window.clearTimeout(t);
    }
  }, [pinError]);

  function press(key: string) {
    if (key === "delete") {
      setDigits((d) => d.slice(0, -1));
      return;
    }
    if (digits.length >= 4) return;
    const next = digits + key;
    setDigits(next);
    if (next.length === 4) submitPin(next);
  }

  return (
    <div className="ios-pin ios-pin--enter ios-pin--figma">
      <div className="ios-pin__material" aria-hidden />
      <div className="ios-pin__content">
        <h1 className="ios-pin__title">Entrez le code</h1>
        <div className={`ios-pin__dots ${shake || pinError ? "ios-pin__dots--shake" : ""}`}>
          {[0, 1, 2, 3].map((i) => (
            <span key={i} className={`ios-pin__dot ${digits.length > i ? "ios-pin__dot--on" : ""}`} />
          ))}
        </div>

        <div className="ios-pin__keypad">
          {ROWS.flatMap((row, ri) =>
            row.map((cell, ci) => {
              if (cell === null) return <div key={`${ri}-${ci}`} className="ios-pin__key ios-pin__key--blank" />;
              if (cell === "delete") {
                return (
                  <button
                    key={`${ri}-${ci}`}
                    type="button"
                    className="ios-pin__key ios-pin__key--delete"
                    onClick={() => press("delete")}
                    aria-label="Effacer"
                  >
                    <BackspaceIcon />
                  </button>
                );
              }
              return (
                <button
                  key={`${ri}-${ci}`}
                  type="button"
                  className="ios-pin__key"
                  onClick={() => press(cell.digit)}
                >
                  <span className="ios-pin__num">{cell.digit}</span>
                  {cell.sub && <span className="ios-pin__letters">{cell.sub}</span>}
                </button>
              );
            })
          )}
        </div>

        <footer className="ios-pin__footer">
          <button type="button" className="ios-pin__link" onClick={cancelPin}>
            Annuler
          </button>
          <button type="button" className="ios-pin__link ios-pin__link--emergency">
            Urgence
          </button>
        </footer>
        <HomeIndicator />
      </div>
    </div>
  );
}
