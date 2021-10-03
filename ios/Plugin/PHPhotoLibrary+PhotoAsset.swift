import Photos.PHPhotoLibrary
import Photos.PHAsset

// https://gist.github.com/ricardopereira/636ccd0a3c8a327c43d42e7cbca4d041
extension PHPhotoLibrary {

    typealias PhotoAsset = PHAsset
    typealias PhotoAlbum = PHAssetCollection

    static func saveImage(url: URL, albumName: String, completion: @escaping (PHAsset?, Error?) -> ()) {

        if let album = self.findAlbum(albumName: albumName) {
            saveImage(url: url, album: album, completion: completion);
            return;
        }

        createAlbum(albumName: albumName) { album, error  in
            if let album = album {
                self.saveImage(url: url, album: album, completion: completion);
            }
            else {
                completion(nil, error);
            }
        }
    }

    static private func saveImage(url: URL, album: PhotoAlbum, completion: @escaping (PHAsset?, Error?)->()) {

        var placeholder: PHObjectPlaceholder?

        PHPhotoLibrary.shared().performChanges({

            // request creating an asset from the image
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url);

            // request editing the album
            guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album) else {
                assert(false, "Album change request failed");
                return;
            }

            // get a placeholder for the new asset and add it to the album editing request
            guard let photoPlaceholder = createAssetRequest?.placeholderForCreatedAsset else {
                assert(false, "Placeholder is nil");
                return;
            }

            placeholder = photoPlaceholder;

            albumChangeRequest.addAssets([photoPlaceholder] as NSFastEnumeration);

        }, completionHandler: { success, error in

            guard let placeholder = placeholder else {
                completion(nil, NSError(domain: "Placeholder is nil", code: 500));
                return;
            }

            if success {
                let assets = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil);
                completion(assets[0], nil);
            } else {
                completion(nil, error ?? NSError(domain: "Unknow error, when adding file to multimedia library", code: 500));
            }
        })
    }

    static func saveVideo(url: URL, albumName: String, completion: @escaping (PHAsset?, Error?) -> ()) {

        if let album = self.findAlbum(albumName: albumName) {
            saveVideo(url: url, album: album, completion: completion);
            return;
        }

        createAlbum(albumName: albumName) { album, error  in
            if let album = album {
                self.saveVideo(url: url, album: album, completion: completion);
            }
            else {
                completion(nil, error);
            }
        }
    }

    static private func saveVideo(url: URL, album: PhotoAlbum, completion: @escaping (PHAsset?, Error?)->()) {

        var placeholder: PHObjectPlaceholder?

        PHPhotoLibrary.shared().performChanges({

            // request creating an asset from the image
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url);

            // request editing the album
            guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album) else {
                assert(false, "Album change request failed");
                return;
            }

            // get a placeholder for the new asset and add it to the album editing request
            guard let photoPlaceholder = createAssetRequest?.placeholderForCreatedAsset else {
                assert(false, "Placeholder is nil");
                return;
            }

            placeholder = photoPlaceholder;

            albumChangeRequest.addAssets([photoPlaceholder] as NSFastEnumeration);

        }, completionHandler: { success, error in

            guard let placeholder = placeholder else {
                completion(nil, NSError(domain: "Placeholder is nil", code: 500));
                return;
            }

            if success {
                let assets = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil);
                completion(assets[0], nil);
            } else {
                completion(nil, error ?? NSError(domain: "Unknown error, when adding file to multimedia library", code: 500));
            }
        })
    }

    static func findAlbum(albumName: String) -> PhotoAlbum? {

        let fetchOptions = PHFetchOptions();
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName);

        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: fetchOptions);

        guard let photoAlbum = fetchResult.firstObject else {
            return nil;
        }

        return photoAlbum;
    }

    static func createAlbum(albumName: String, completion: @escaping (PhotoAlbum?, Error?)->()) {

        var albumPlaceholder: PHObjectPlaceholder?;

        PHPhotoLibrary.shared().performChanges({

            // request creating an album with parameter name
            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName);

            // get a placeholder for the new album
            albumPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection;
        }, completionHandler: { success, error in

            guard let placeholder = albumPlaceholder else {
                completion(nil, NSError(domain: "Album placeholder is nil", code: 500));
                return;
            }

            let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil);

            guard let album = fetchResult.firstObject else {
                completion(nil, NSError(domain: "FetchResult has no PHAssetCollection", code: 500));
                return;
            }

            if success {
                completion(album, nil);
            } else {
                completion(nil, error ?? NSError(domain: "Unknown error when creating multimedia album", code: 500));
            }
        })
    }

}
