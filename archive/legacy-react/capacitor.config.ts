import type { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "com.lostphone.game",
  appName: "Lost Phone",
  webDir: "dist",
  server: {
    androidScheme: "https",
    iosScheme: "capacitor",
  },
  ios: {
    contentInset: "automatic",
    scrollEnabled: false,
    backgroundColor: "#000000",
    allowsLinkPreview: false,
    preferredContentMode: "mobile",
  },
  plugins: {
    SplashScreen: {
      launchAutoHide: true,
      launchShowDuration: 800,
      backgroundColor: "#000000",
      showSpinner: false,
      iosSpinnerStyle: "small",
    },
    StatusBar: {
      overlaysWebView: true,
      style: "LIGHT",
      backgroundColor: "#00000000",
    },
    Keyboard: {
      resize: "body",
      style: "dark",
      resizeOnFullScreen: true,
    },
  },
};

export default config;
