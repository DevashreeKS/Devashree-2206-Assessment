//
//  ViewModelDelegate.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 12/02/21.
//

import Foundation


protocol Presenting {
    
    func presentError(title: String, message: String)

}


protocol ViewModelDelegate: class, Presenting {}


extension ViewModelDelegate {

    func handleCommonAPIError(error: APIError) {
        switch error {
        case .noInternet:
            presentError(title: StringConstants.appName,
                         message: StringConstants.AlertMessages.noInternet)
        case .invalidRequest:
            presentError(title: StringConstants.appName, message: StringConstants.AlertMessages.invalidRequest)
        case .invalidJSON:
            presentError(title: StringConstants.appName, message: StringConstants.AlertMessages.invalidJSON)
        }
    }
    
}
