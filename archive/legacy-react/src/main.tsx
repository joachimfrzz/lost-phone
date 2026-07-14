import { StrictMode, useEffect, useState } from "react";
import { createRoot } from "react-dom/client";
import App from "./App";
import "./index.css";
import "./ios/ios-ui.css";
import "./ios/apps.css";
import "./ios/native.css";
import "./ios/reference-calibration.css";
import "./ios/captures.css";
import { initNativeShell } from "./lib/native";

function Root() {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    initNativeShell().finally(() => setReady(true));
  }, []);

  if (!ready) {
    return <div className="iphone-wake" aria-hidden />;
  }

  return <App />;
}

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <Root />
  </StrictMode>,
);
