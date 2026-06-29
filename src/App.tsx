import { BrowserRouter, Navigate, Route, Routes } from "react-router-dom";
import { CaptureReviewPage } from "./pages/CaptureReviewPage";
import { CaptureUploadPage } from "./pages/CaptureUploadPage";
import { HubPage } from "./pages/HubPage";
import { PhonePage } from "./pages/PhonePage";
import { SimulatorPage } from "./pages/SimulatorPage";
import { UiReferencePage } from "./pages/UiReferencePage";

function HomeRoute() {
  return <Navigate to="/phone/j3-louvre" replace />;
}

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomeRoute />} />
        <Route path="/hub" element={<HubPage />} />
        <Route path="/simulator" element={<SimulatorPage />} />
        <Route path="/captures-upload" element={<CaptureUploadPage />} />
        <Route path="/captures-review" element={<CaptureReviewPage />} />
        <Route path="/ui-reference" element={<UiReferencePage />} />
        <Route path="/phone/:storyId" element={<PhonePage />} />
      </Routes>
    </BrowserRouter>
  );
}
