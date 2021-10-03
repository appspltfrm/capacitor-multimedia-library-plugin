export interface MultimediaLibraryPlugin {
    saveImage(call: {
        file: string;
        album?: string;
    }): Promise<{
        filePath: string;
    }>;
    saveVideo(call: {
        file: string;
        album?: string;
    }): Promise<{
        filePath: string;
    }>;
}
