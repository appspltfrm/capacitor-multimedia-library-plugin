import { WebPlugin } from "@capacitor/core";
import type { MultimediaLibraryPlugin } from "./MultimediaLibraryPlugin";
export declare class MultimediaLibraryWebPlugin extends WebPlugin implements MultimediaLibraryPlugin {
    saveImage(_call: {
        file: string;
        album?: string;
    }): Promise<{
        filePath: string;
    }>;
    saveVideo(_call: {
        file: string;
        album?: string;
    }): Promise<{
        filePath: string;
    }>;
}
