import { useState } from "react";
import { BackspaceIcon } from "../components/ios/StatusIcons";
import { usePhone } from "../runtime/PhoneProvider";

const ROWS: Array<Array<{ digit: string; sub?: string } | null>> = [
  [{ digit: "1" }, { digit: "2", sub: "ABC" }, { digit: "3", sub: "DEF" }],
  [{ digit: "4", sub: "GHI" }, { digit: "5", sub: "JKL" }, { digit: "6", sub: "MNO" }],
  [{ digit: "7", sub: "PQRS" }, { digit: "8", sub: "TUV" }, { digit: "9", sub: "WXYZ" }],
  [null, { digit: "0" }, { digit: "delete" }],
];

export function PinPad() {
  const { submitPin, pinError, cancelPin } = usePhone();
  const [digits, setDigits] = useState("");

  function press(key: string) {
    if (key === "delete") {
      setDigits((d) => d.slice(0, -1));
      return;
    }
    if (digits.length >= 4) return;
    const next = digits + key;
    setDigits(next);
    if (next.length === 4) {
      submitPin(next);
      window.setTimeout(() => setDigits(""), 500);
    }
  }

  return (
    <div className="os-pin">
      <p className="os-pin__label">Code d&apos;accès</p>
      <div className="os-pin__dots">
        {[0, 1, 2, 3].map((i) => (
          <span key={i} className={`os-pin__dot ${digits.length > i ? "filled" : ""} ${pinError ? "error" : ""}`} />
        ))}
      </div>
      {pinError && <p className="os-pin__error">Code incorrect</p>}

      <div className="os-pin__pad">
        {ROWS.flatMap((row, ri) =>
          row.map((cell, ci) => {
            if (!cell) return <span key={`${ri}-${ci}`} className="os-pin__key os-pin__key--empty" />;
            if (cell.digit === "delete") {
              return (
                <button key={`${ri}-${ci}`} type="button" className="os-pin__key os-pin__key--delete" onClick={() => press("delete")}>
                  <BackspaceIcon />
                </button>
              );
            }
            return (
              <button key={`${ri}-${ci}`} type="button" className="os-pin__key" onClick={() => press(cell.digit)}>
                <span className="os-pin__digit">{cell.digit}</span>
                {cell.sub && <span className="os-pin__sub">{cell.sub}</span>}
              </button>
            );
          })
        )}
      </div>

      <button type="button" className="os-pin__cancel" onClick={cancelPin}>
        Annuler
      </button>
    </div>
  );
}
