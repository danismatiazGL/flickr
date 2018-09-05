//
//  NetworkConstants.swift
//  Flickr
//
//  Created by Danis Matiaz on 9/5/18.
//  Copyright © 2018 Danis Matiaz - Gorilla Logic. All rights reserved.
//

import Foundation

// MARK: - Base Flickr Service
struct NetworkConstant {
    static let flickrBaseURL = "https://api.flickr.com/services/rest/"
    static let flickrAPIKey = "204392aa0e948796d40ecfdf189cef11" // TO DO: Secure this key
}

// MARK: - Flickr Services
enum FlickrService: String {
    case search = "?method=flickr.photos.search"
}

// MARK: - Flickr Service Parameters, for the purpose of the challenge these are hardcoded
enum FlickrServiceParameter: String {
    case apiKey = "api_key="
    case text = "text="
    case extras = "extras=url_s"
    case format = "format=json"
    case nojson = "nojsoncallback=1"
    case page = "page="
}

// Flickr API Keys
enum FlickrAPIKey: String {
    case photos = "photos"
    case page = "page"
    case pages = "pages"
    case perpage = "perpage"
    case total = "total"
    case photo = "photo"
    case photoId = "photoId"
    case serverId = "serverId"
    case farmId = "farmId"
    case secretId = "secretId"
    case url = "url_s"
}
