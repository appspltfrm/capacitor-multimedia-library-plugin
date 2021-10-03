import {WebPlugin} from "@capacitor/core";

import type {MultimediaLibraryPlugin} from "./MultimediaLibraryPlugin";

export class MultimediaLibraryWebPlugin extends WebPlugin implements MultimediaLibraryPlugin {

	saveImage(_call: {file: string, album?: string}): Promise<{filePath: string}> {
		throw new Error("Method not implemented.");
	}

	saveVideo(_call: {file: string, album?: string}): Promise<{filePath: string}> {
		throw new Error("Method not implemented.");
	}
}
