//
//  PhotoplayViewModel.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import Foundation
import UIKit
import SwiftyJSON


protocol PhotoplayDetailViewModelDelegate: ViewModelDelegate {
    
    func presentError(title: String, message: String)
    func handleLoader(_ shouldShow: Bool)
    func updateLineColor(_ type: PhotoplayViewType)
    
}

class PhotoplayDetailViewModel : NSObject {
    
    // MARK: - Variables
    
    var photosData : PhotoplayModel!
    var photoPlayViewType: PhotoplayType = .photo
    var i = 0
    
    // MARK: - Overrides
    
    override init() {
        
        super.init()
        
        
    }
    
}
