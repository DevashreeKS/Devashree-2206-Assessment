//
//  Constants.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 12/02/21.
//

import Foundation

struct StringConstants {
    
    // MARK: - App details
    
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    static let defaultSearch = "animal"
    
    // MARK: - StoryboardIdentifiers
    
    struct StoryboardIdentifiers {
        
        struct Cells {
            static let photoPlayCell = "PhotoplayTableViewCell"
        }
        
        struct Storyboards {
            static let main = "Main"
            static let detailVC = "PhotoplayDetailController"
        }
        
    }
    
    
    // MARK: - Alert messages
    
    struct AlertMessages {
        static let noInternet = "Please check your internet connectivity & try again !"
        static let invalidRequest = "Invalid Request !"
        static let invalidJSON = "Invalid data, please try again !"
        static let emailEmpty = "Please enter email address"
        static let sameUserErrorMessage = "This is your post. Please click on profile to continue."
    }
    
    // MARK: - API Parameters
    
    struct APIParams {
        
        static let query = "query"
        static let perPage = "per_page"
        static let photographer = "photographer"
        static let medium = "medium"
        static let src = "src"
        static let id = "id"
        static let photos = "photos"
        
    }

}

let perPageItems = 20
let theme = 0xD5334A
let lighttheme = 0xD6D4C1
