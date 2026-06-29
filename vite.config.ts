import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { captureUploadPlugin } from "./vite-plugins/captureUpload";

export default defineConfig({
  plugins: [react(), captureUploadPlugin()],
  base: "./",
  build: {
    outDir: "dist",
    assetsDir: "assets",
  },
  server: {
    port: 5174,
    host: true,
  },
});
