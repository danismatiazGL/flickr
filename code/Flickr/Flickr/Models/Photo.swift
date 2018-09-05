//
//  Photo.swift
//  Flickr
//
//  Created by Danis Matiaz on 9/5/18.
//  Copyright © 2018 Danis Matiaz - Gorilla Logic. All rights reserved.
//

import Foundation

class Photo {
    var photoId: String = ""
    var serverId: String = ""
    var farmId: String = ""
    var secretId: String = ""
    var url: String = ""
    init(photoId: String,
         serverId: String,
         farmId: String,
         secretId: String,
         url: String) {
        self.photoId = photoId
        self.serverId = serverId
        self.farmId = farmId
        self.secretId = secretId
        self.url = url
    }
}
