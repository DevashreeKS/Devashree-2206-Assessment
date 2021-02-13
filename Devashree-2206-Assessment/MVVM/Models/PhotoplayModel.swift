//
//  SampleModel.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import Foundation
import SwiftyJSON


struct ResourceSize: Codable {
    
    let original: String?
    let large2x: String?
    let large: String?
    let medium: String?
    let small: String?
    let portrait: String?
    let landscape: String?
    let tiny: String?
    
}


struct Photo: Codable {
    
    let id: Int?
    let width: Int?
    let height: Int?
    let url: String?
    let photographer: String?
    let photographer_url: String?
    let photographer_id: Int?
    let avg_color: String?
    let src: [ResourceSize]?
    var isFavorite = false
    
}


struct PhotoplayData: Codable {
    
    let page: Int?
    let perpage: Int?
    let totalResults: Int?
    let nextpage: String?
    let photos: [[Photo]]?

    enum CodingKeys: String, CodingKey {
        
        case page
        case perpage = "per_page"
        case totalResults = "total_results"
        case nextpage = "next_page"
        case photos
        
    }
}


struct PhotoplayModel {
    var type: PhotoplayType = .photo
    var data: JSON
    var videoData: JSON = JSON(stringLiteral: "")
    var favoriteIds: [Int] = []
    
    var isPhoto: Bool {
        self.type == .photo
    }
}
