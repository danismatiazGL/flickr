//
//  NetworkManager.swift
//  Flickr
//
//  Created by Danis Matiaz on 9/5/18.
//  Copyright © 2018 Danis Matiaz - Gorilla Logic. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class NetworkManager: NSObject {}

enum ServiceStatus: Int {
    case failure
    case success
}

// MARK: - Request URL Builder
extension NetworkManager {
    private static func baseRequest(service: FlickrService) -> String {
        return "\(NetworkConstant.flickrBaseURL)\(service.rawValue)"
    }

    private static func searchRequest(query: String, page: Int) -> String {
        let baseURL = self.baseRequest(service: query.count == 0 ? .recent : .search)
        var queryEncoded = ""
        if let encodedString = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            queryEncoded = encodedString
        }
        let baseParameters = "\(baseURL)\(self.flickerAPIKey())\(self.searchParameters())"
        let searchParameters = queryEncoded.count == 0 ? "" : "\(self.searchQuery(query: queryEncoded))"
        let pageParameters = "\(self.searchPage(page: page))"
        return "\(baseParameters)\(pageParameters)\(searchParameters)"
    }

    private static func flickerAPIKey() -> String {
        return "&\(FlickrServiceParameter.apiKey.rawValue)\(NetworkConstant.flickrAPIKey)"
    }

    private static func searchParameters() -> String {
        let extras = FlickrServiceParameter.extras.rawValue
        let callback = FlickrServiceParameter.callback.rawValue
        let format = FlickrServiceParameter.format.rawValue
        return "&\(extras)&\(callback)&\(format)"
    }

    private static func searchQuery(query: String) -> String {
        return "&\(FlickrServiceParameter.text.rawValue)\(query)"
    }

    private static func searchPage(page: Int) -> String {
        return "&\(FlickrServiceParameter.page.rawValue)\(page)"
    }
}

// MARK: - Request URL Builder
extension NetworkManager {
    static func searchPhotos(query: String, page: Int, completion:
        @escaping (_ isSuccess: ServiceStatus, _ response: [Photo]?, _ errorMessage: String) -> Void) {
        let requestURL = NetworkManager.searchRequest(query: query, page: page)
        Alamofire.request(requestURL).responseData { (response) in
            switch response.result {
            case .success:
                if let responseData = response.result.value {
                    let newPhotos = DataManager.serializePhotos(data: responseData)
                    completion(.success, newPhotos, "")
                } else {
                    completion(.failure, nil, "No data available")
                }
            case .failure(let error):
                completion(.failure, nil, error.localizedDescription)
            }
        }
    }
}
