import {registerPlugin} from "@capacitor/core";

import type {MultimediaLibraryWebPlugin} from "./MultimediaLibraryWebPlugin";

export * from "./MultimediaLibraryPlugin";
export * from "./MultimediaLibraryWebPlugin";

const MultimediaLibrary = registerPlugin<MultimediaLibraryWebPlugin>("MultimediaLibrary", {
    web: () => import("./MultimediaLibraryWebPlugin").then(m => new m.MultimediaLibraryWebPlugin())
});

export {MultimediaLibrary};
