'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

class MultimediaLibraryWebPlugin extends core.WebPlugin {
    saveImage(_call) {
        throw new Error("Method not implemented.");
    }
    saveVideo(_call) {
        throw new Error("Method not implemented.");
    }
}

var MultimediaLibraryWebPlugin$1 = /*#__PURE__*/Object.freeze({
    __proto__: null,
    MultimediaLibraryWebPlugin: MultimediaLibraryWebPlugin
});

const MultimediaLibrary = core.registerPlugin("MultimediaLibrary", {
    web: () => Promise.resolve().then(function () { return MultimediaLibraryWebPlugin$1; }).then(m => new m.MultimediaLibraryWebPlugin())
});

exports.MultimediaLibrary = MultimediaLibrary;
exports.MultimediaLibraryWebPlugin = MultimediaLibraryWebPlugin;
//# sourceMappingURL=plugin.cjs.js.map
