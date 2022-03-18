import Alpine from "alpinejs";
import uploader from "./uploader";

declare global {
  interface Window {
    Alpine: typeof Alpine;
    uploader: typeof uploader;
  }
}

window.uploader = uploader;

window.Alpine = Alpine;
Alpine.start();
