import { registerPlugin } from "@capacitor/core";
export * from "./MultimediaLibraryPlugin";
export * from "./MultimediaLibraryWebPlugin";
const MultimediaLibrary = registerPlugin("MultimediaLibrary", {
    web: () => import("./MultimediaLibraryWebPlugin").then(m => new m.MultimediaLibraryWebPlugin())
});
export { MultimediaLibrary };
//# sourceMappingURL=index.js.map