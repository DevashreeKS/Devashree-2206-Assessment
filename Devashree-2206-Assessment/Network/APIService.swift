//
//  APIDataManager.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import Foundation
import SwiftyJSON

// MARK: - Server Base URL

private let kBaseURL = "https://api.pexels.com"
private let kApiKey = "563492ad6f91700001000001524d105ce77144b791b7bffb0df78798"


// MARK: - API Prefixes

enum APIPrefix: String {
    case photos = "/v1"
    case videos = "/videos"
}


// MARK: - API's list
enum API: String {

    case photoAPI = "/photos"
    case videoAPI = "/videos"
    case searchAPI = "/search"
    case curateAPI = "/curated"
    case testAPI = "https://api.letsbuildthatapp.com/jsondecodable/course"
    
    
    var withBaseURL: String {
        return kBaseURL + APIPrefix.photos.rawValue + self.rawValue
    }

    
    func withBaseUrlAndPrefix(prefix: APIPrefix) -> String {
        return kBaseURL + prefix.rawValue + self.rawValue
    }
    
}


enum ServiceName: String {

    case linkAadhaarPreLoginService
    case linkAadhaarValidationService
    case linkAadharOtpService

}


enum APIError {
    
    case noInternet
    case invalidRequest
    case invalidJSON
    
}

//563492ad6f91700001000001524d105ce77144b791b7bffb0df78798

class APIService {
    
    // MARK: - Photos
    
    func getPhotos(query: String, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void) {
        
        NetworkManager.getURL(urlString: API.searchAPI.withBaseURL,
                              params: query,
                              key: kApiKey) { (JSONResponse) in
            success(JSONResponse)
        } failure: { (error) in
            failure (error)
        }
        
    }
    
    // MARK: - Curated photos - Banner image
    
    func getBannerImage(query: String, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void) {
        
        NetworkManager.getURL(urlString: API.curateAPI.withBaseURL,
                              params: query,
                              key: kApiKey) { (JSONResponse) in
            success(JSONResponse)
        } failure: { (error) in
            failure (error)
        }
        
    }
    
    // MARK: - Videos
    
    func getVideo(query: String, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void) {
        
        NetworkManager.getURL(urlString: API.videoAPI.withBaseURL,
                              params: query,
                              key: kApiKey) { (JSONResponse) in
            success(JSONResponse)
        } failure: { (error) in
            failure (error)
        }
        
    }
    
}
