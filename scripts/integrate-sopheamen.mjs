/**
 * Intègre les clones Sopheamen — préfixe tous les types par app (stratégie showroom).
 */
import fs from "fs";
import path from "path";

const ROOT = path.resolve("LostPhone/LostPhone/Apps/Sopheamen");
const OUT = path.join(ROOT, "Integrated");

const APPS = [
  { lpsp: "TikTok", src: "Youtube_Tiktok_v1/Youtube_Tiktok_v1/Youtube_Tiktok", prefix: "TikTok", outEntry: "TikTokTikTokView", patchFiles: ["TikTokIconView.swift"] },
  { lpsp: "Uber", src: "Youtube_uber_clone_v1/Youtube_uber_clone_v1/Youtube_uber_clone", prefix: "Uber", outEntry: "UberUberHomeView", patch: "uber-rides-only" },
  { lpsp: "Uber Eats", src: "food-delivery-ui-kit-cart-checkout/food-delivery-ui-kit-cart-checkout/food-delivery-ui-kit-v1", prefix: "UberEats", outEntry: "UberEatsUberEatsHomeView" },
  { lpsp: "Facebook", src: "Youtube_Facebook_v1/Youtube_Facebook_v1/Youtube_Facebook", prefix: "Facebook", outEntry: "FacebookFacebookHome", patch: "contrast" },
  { lpsp: "Messenger", src: "Youtube_FacebookMessenger_v1/Youtube_FacebookMessenger_v1/Youtube_FacebookMessenger", prefix: "Messenger", outEntry: "MessengerMessengerHome", patch: "contrast" },
  { lpsp: "Gemini", src: "Youtube_Gemini_clone_v1/Youtube_Gemini_clone_v1/Youtube_Gemini_clone", prefix: "Gemini", outEntry: "GeminiGeminiHomeView", patch: "contrast" },
  { lpsp: "Instagram", src: "Instagram clone patreon/Instagram clone patreon/Instagram clone", prefix: "Instagram", outEntry: "InstagramInstagramHome" },
  { lpsp: "WhatsApp", src: "WhatsAppclone patreon/WhatsAppclone patreon/WhatsAppclone", prefix: "WhatsApp", outEntry: "WhatsAppWhatsAppContentRoot", patch: "contrast" },
  { lpsp: "Netflix", src: "Youtube_Netflix_v1/Youtube_Netflix_v1/Youtube_Netflix", prefix: "Netflix", outEntry: "NetflixNetflixHome" },
  { lpsp: "YouTube", src: "Youtube_Youtube_v1/Youtube_Youtube_v1/Youtube_Youtube", prefix: "YouTube", outEntry: "YouTubeYouTubeHome", patch: "youtube-branding" },
  { lpsp: "YouTube Music", src: "Youtube_Music_v2_1/Youtube_Music_v2_1/Youtube_Music_v2", prefix: "YTMusic", outEntry: "YTMusicYTMusicHome" },
  { lpsp: "Airbnb", src: "youtube_airbnb_clone_v1/youtube_airbnb_clone_v1/youtube_airbnb_clone", prefix: "Airbnb", outEntry: "AirbnbAirbnbHomeView", patch: "contrast" },
  { lpsp: "LinkedIn", src: "LinkedIn Clone patreon/LinkedIn Clone patreon/LinkedIn Clone", prefix: "LinkedIn", outEntry: "LinkedInLinkedInHome" },
  { lpsp: "Snapchat", src: "Snapchat Clone patreon/Snapchat Clone patreon/Snapchat Clone", prefix: "Snapchat", outEntry: "SnapchatSnapchatContentRoot", patch: "snapchat-contrast" },
  { lpsp: "App Store", src: "Youtube_Appstore _v1/Youtube_Appstore _v1/Youtube_Appstore", prefix: "AppStore", outEntry: "AppStoreAppStoreHome" },
  { lpsp: "Wallet", src: "Youtube_Phantom_clone_v1/Youtube_Phantom_clone_v1/Youtube_Phantom_clone", prefix: "Phantom", outEntry: "PhantomPhantomHome" },
  { lpsp: "Threads", src: "Youtube_Threads_v1/Youtube_Threads_v1/Youtube_Threads", prefix: "Threads", outEntry: "ThreadsThreadsHome", disabled: true },
];

const SKIP = /App\.swift$|Preview Content|\.xcodeproj/;

const SHARED_COLOR = `import SwiftUI

extension Color {
    init(sopheamenHex hex: String, opacity: Double = 1.0) {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
`;

function walk(dir) {
  const out = [];
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (SKIP.test(ent.name)) continue;
      out.push(...walk(p));
    } else if (ent.name.endsWith(".swift") && !SKIP.test(ent.name)) {
      out.push(p);
    }
  }
  return out;
}

function prefixAllTypes(text, prefix) {
  const types = new Set();
  for (const m of text.matchAll(/\b(struct|enum|class)\s+([A-Z][A-Za-z0-9_]*)/g)) types.add(m[2]);
  let t = text;
  for (const name of [...types].sort((a, b) => b.length - a.length)) {
    if (name.startsWith(prefix)) continue;
    const p = `${prefix}${name}`;
    t = t.replaceAll(`struct ${name}`, `struct ${p}`);
    t = t.replaceAll(`enum ${name}`, `enum ${p}`);
    t = t.replaceAll(`class ${name}`, `class ${p}`);
    t = t.replaceAll(`${name}(`, `${p}(`);
    t = t.replaceAll(`${name}.self`, `${p}.self`);
    t = t.replaceAll(`: ${name}`, `: ${p}`);
    t = t.replaceAll(`<${name}>`, `<${p}>`);
    t = t.replaceAll(`[${name}]`, `[${p}]`);
    t = t.replaceAll(`extension ${name}`, `extension ${p}`);
  }
  if (t.includes("init(hex:")) {
    t = t.replace(/init\(hex:/g, "init(sopheamenHex:");
    t = t.replace(/Color\(hex:/g, "Color(sopheamenHex:");
  }
  return t;
}

function patchText(text, patch) {
  if (!patch) return text;
  if (patch === "uber-rides-only") {
    return text
      .replace("@State private var selectedIndex = 1", "@State private var selectedIndex = 0")
      .replace(/VStack \{[\s\S]*?if selectedIndex == 0 \{[\s\S]*?\} else \{[\s\S]*?\}\s*\}/m,
        `VStack (spacing:10){
                            SearchRidesView()
                            RidesHistoryView()
                            SuggestionView()
                            AdsView()
                        }`);
  }
  if (patch === "contrast") {
    return text
      .replace(/\.foregroundStyle\(\.white\)/g, ".foregroundStyle(.primary)")
      .replace(/\.foregroundColor\(\.white\)/g, ".foregroundColor(.primary)");
  }
  if (patch === "snapchat-contrast") {
    return text.replace(/\.foregroundColor\(\.black\)/g, ".foregroundColor(.primary)");
  }
  if (patch === "youtube-branding") {
    return text.replace(/Disney/g, "YouTube");
  }
  return text;
}

fs.rmSync(OUT, { recursive: true, force: true });
fs.mkdirSync(OUT, { recursive: true });
fs.writeFileSync(path.join(OUT, "SopheamenColorHex.swift"), SHARED_COLOR);

const manifest = [];
for (const app of APPS) {
  const srcDir = path.join(ROOT, app.src);
  if (!fs.existsSync(srcDir)) { console.warn("missing", app.lpsp); continue; }
  const destDir = path.join(OUT, app.lpsp.replace(/[^a-zA-Z0-9]/g, ""));
  fs.mkdirSync(destDir, { recursive: true });
  for (const file of walk(srcDir)) {
    const rel = path.relative(srcDir, file);
    const dest = path.join(destDir, rel);
    fs.mkdirSync(path.dirname(dest), { recursive: true });
    let text = prefixAllTypes(fs.readFileSync(file, "utf8"), app.prefix);
    if (rel.includes("Themes") && text.includes("extension Color") && text.includes("sopheamenHex")) {
      text = text.replace(/extension Color \{[\s\S]*?init\(sopheamenHex[\s\S]*?\}\s*/m, "extension Color {\n");
    }
    if (app.patch) text = patchText(text, app.patch);
    fs.writeFileSync(dest, text);
  }
  const assets = path.join(srcDir, "Assets.xcassets");
  if (fs.existsSync(assets)) fs.cpSync(assets, path.join(destDir, "Assets.xcassets"), { recursive: true });
  for (const f of fs.readdirSync(srcDir).filter((x) => x.endsWith(".ttf"))) {
    fs.copyFileSync(path.join(srcDir, f), path.join(destDir, f));
  }
  manifest.push({ lpsp: app.lpsp, outEntry: app.outEntry, disabled: app.disabled ?? false });
  console.log("OK", app.lpsp);
}
fs.writeFileSync(path.join(OUT, "manifest.json"), JSON.stringify(manifest, null, 2));
