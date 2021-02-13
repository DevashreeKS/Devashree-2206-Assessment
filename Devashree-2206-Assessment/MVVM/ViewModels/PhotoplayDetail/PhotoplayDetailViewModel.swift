//
//  PhotoplayViewModel.swift
//  MVVM_New
//
//  Created by Abhilash Mathur on 20/05/20.
//  Copyright © 2020 Abhilash Mathur. All rights reserved.
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
