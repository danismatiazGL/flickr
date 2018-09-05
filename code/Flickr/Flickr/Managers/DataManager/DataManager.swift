//
//  DataManager.swift
//  Flickr
//
//  Created by Danis Matiaz on 9/5/18.
//  Copyright © 2018 Danis Matiaz - Gorilla Logic. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager: NSObject {}

enum DataStatus: Int {
    case success
    case failure
}

// MARK: - Data Manager
extension DataManager {
    static func savePhotos(photos: String, completion:
        @escaping (_ isSuccess: Bool, _ response: ServiceStatus, _ errorMessage: String) -> Void) {
        // To DO: save the response objects locally using Core Data or Realm
        // to enable the offline functionallity and reuse the data
    }
}

extension DataManager {
    static func serializePhotos(data: Data) -> [Photo] {
        var newPhotos: [Photo] = []
        do {
            let json = try JSON(data: data)
            let photos = json[FlickrAPIKey.photos.rawValue][FlickrAPIKey.photo.rawValue].arrayValue
            for photo in photos {
                let newPhoto = self.photo(with: photo)
                newPhotos.append(newPhoto)
            }
            return newPhotos
        } catch {
            print("To do: Error Handling")
            return []
        }
    }

    static func photo(with data: JSON) -> Photo {
        let photoId: String = data[FlickrAPIKey.photoId.rawValue].stringValue
        let serverId: String = data[FlickrAPIKey.serverId.rawValue].stringValue
        let farmId: String = data[FlickrAPIKey.farmId.rawValue].stringValue
        let secretId: String = data[FlickrAPIKey.secretId.rawValue].stringValue
        let url: String = data[FlickrAPIKey.url.rawValue].stringValue
        let newPhoto: Photo = Photo.init(photoId: photoId,
                                         serverId: serverId,
                                         farmId: farmId,
                                         secretId: secretId,
                                         url: url)
        return newPhoto
    }
}
