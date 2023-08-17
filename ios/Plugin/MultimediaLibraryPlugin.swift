import Foundation
import Capacitor
import Photos.PHPhotoLibrary

@objc(MultimediaLibraryPlugin)
public class MultimediaLibraryPlugin: CAPPlugin {

    @objc func saveImage(_ call: CAPPluginCall) {

        var status: PHAuthorizationStatus;
        
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        };

        if (status == PHAuthorizationStatus.authorized) {
            doSaveImage(call);

        } else if (status == PHAuthorizationStatus.notDetermined) {

            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) {status in
                    if (status == PHAuthorizationStatus.authorized) {
                        self.doSaveImage(call);
                    } else {
                        self.rejectNotAuthorized(call);
                        return;
                    }
                }
            } else {
                PHPhotoLibrary.requestAuthorization {status in
                    if (status == PHAuthorizationStatus.authorized) {
                        self.doSaveImage(call);
                    } else {
                        self.rejectNotAuthorized(call);
                        return;
                    }
                }
            }

        } else {
            rejectNotAuthorized(call);
            return;
        }

    }

    @objc func saveVideo(_ call: CAPPluginCall) {

        var status: PHAuthorizationStatus;
        
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        };

        if (status == PHAuthorizationStatus.authorized) {
            doSaveVideo(call);

        } else if (status == PHAuthorizationStatus.notDetermined) {

            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) {status in
                    if (status == PHAuthorizationStatus.authorized) {
                        self.doSaveVideo(call);
                    } else {
                        self.rejectNotAuthorized(call);
                        return;
                    }
                }
            } else {
                PHPhotoLibrary.requestAuthorization {status in
                    if (status == PHAuthorizationStatus.authorized) {
                        self.doSaveVideo(call);
                    } else {
                        self.rejectNotAuthorized(call);
                        return;
                    }
                }
            }

        } else {
            rejectNotAuthorized(call);
            return;
        }

    }

    func rejectNotAuthorized(_ call: CAPPluginCall) {
        call.reject("@appspltfrm/capacitor-multimedia-library-plugin/MissingPermissionError");
    }

    func doSaveImage(_ call: CAPPluginCall) {

        let inputPath = call.getString("file");
        if (inputPath == nil) {
            call.reject("Input file path must be given");
            return;
        }

        let inputUrl = URL(string: inputPath!);

        if (!FileManager.default.fileExists(atPath: inputUrl!.path)) {
            call.reject("Input file not exists");
            return;
        }

        let albumName = call.getString("album");
        if (albumName == nil) {
            call.reject("Destination album name must be given");
            return;
        }

        PHPhotoLibrary.saveImage(url: inputUrl!, albumName: albumName!, completion: { imageAsset, error in
            if (imageAsset != nil) {
                var result: [String: Any] = [:];
                result["fileId"] = imageAsset?.burstIdentifier;

                imageAsset!.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { (input, _) in
                    result["filePath"] = input!.fullSizeImageURL?.path;
                    call.resolve(result);
                }

            } else {
                call.reject("Unknown error, image not saved in the library", nil, error)
            }
        });
    }

    func doSaveVideo(_ call: CAPPluginCall) {

        let inputPath = call.getString("file");
        if (inputPath == nil) {
            call.reject("Input file path must be given");
            return;
        }

        let inputUrl = URL(string: inputPath!);

        if (!FileManager.default.fileExists(atPath: inputUrl!.path)) {
            call.reject("Input file not exists");
            return;
        }

        let albumName = call.getString("album");
        if (albumName == nil) {
            call.reject("Destination album name must be given");
            return;
        }

        PHPhotoLibrary.saveVideo(url: inputUrl!, albumName: albumName!, completion: { imageAsset, error in
            if (imageAsset != nil) {
                var result: [String: Any] = [:];
                result["fileId"] = imageAsset?.burstIdentifier;

                imageAsset!.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { (input, _) in
                    result["filePath"] = input!.fullSizeImageURL?.path;
                    call.resolve(result);
                }

            } else {
                call.reject("Unknown error, video not saved in the library", nil, error);
            }
        });
    }

}
