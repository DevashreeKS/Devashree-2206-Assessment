//
//  NetworkManager.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 12/02/21.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

typealias json = JSON

struct MediaDetails {
    
    var data: Data!
    var key: String!
    var name: String!
    var mimeType: String!

}


class NetworkManager: NSObject {
    
    // MARK: - GET Request
    
    class func getURL(urlString: String, params: String, key: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        let headers : HTTPHeaders = ["Content-Type":"application/json",
                                     "Authorization":"Bearer \(key)"]
        AF.request("\(urlString)?query=\(params)&per_page=20", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseObject in
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                success(resJson)
            case .failure(let value):
                let error : Error = value
                failure(error)
            }
        }
        
    }
    
    
    // MARK: - POST Request
    
    class func postURL(urlString : String, params : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON { (responseObject) -> Void in
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                success(resJson)
            case .failure(let value):
                let error : Error = value
                failure(error)
            }
        }
        
    }
    
    
    // MARK: - Multipart form data
    
    class func multipartURL(urlString : String, params : [String : String]?, media: MediaDetails?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params! {
                multiPart.append(value.data(using: .utf8)!, withName: key)
            }
            
            if(media != nil) {
                multiPart.append(media!.data, withName: media!.key, fileName: media!.name, mimeType: media!.mimeType)
            }
            
        }, to: urlString)
            .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }).validate().responseJSON { (responseObject) -> Void in
                switch responseObject.result {
                case .success(let value):
                    let resJson = JSON(value)
                    success(resJson)
                case .failure(let value):
                    let error : Error = value
                    failure(error)
                    
                }
        }
        
    }
    
}
