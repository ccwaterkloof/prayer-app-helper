import Alpine from "alpinejs";
import uploader from "./uploader";

window.Alpine = Alpine;
Alpine.data("uploader", uploader);
Alpine.start();
