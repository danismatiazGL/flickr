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
        if service == .search {
            return "\(NetworkConstant.flickrBaseURL)\(service.rawValue)"
        } else {// we don't have other services yet
            return ""
        }
    }

    private static func searchRequest(query: String, page: Int) -> String {
        let baseURL = self.baseRequest(service: .search)
        var queryEncoded = ""
        if let encodedString = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            queryEncoded = encodedString
        }
        let baseParameters = "\(baseURL)\(self.flickerAPIKey())\(self.searchParameters())"
        let searchParameters = "\(self.searchQuery(query: queryEncoded))\(self.searchPage(page: page))"
        return "\(baseParameters)\(searchParameters)"
    }

    private static func flickerAPIKey() -> String {
        return "&\(FlickrServiceParameter.apiKey)\(NetworkConstant.flickrAPIKey)"
    }

    private static func searchParameters() -> String {
        return "&\(FlickrServiceParameter.apiKey)\(NetworkConstant.flickrAPIKey)"
    }

    private static func searchQuery(query: String) -> String {
        return "&\(FlickrServiceParameter.text)\(query)"
    }

    private static func searchPage(page: Int) -> String {
        return "&\(FlickrServiceParameter.page)\(page)"
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
