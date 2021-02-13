//
//  PhotoplayTableViewCell.swift
//  MVVM_New
//
//  Created by Abhilash Mathur on 20/05/20.
//  Copyright © 2020 Abhilash Mathur. All rights reserved.
//

import UIKit
import SwiftyJSON

class PhotoplayTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnIsFavourite: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    
    
    // MARK: - Variables
    
    var photoPlay : PhotoplayModel? {
        
        didSet {
            setupCell()
        }
        
    }
    var markAsFavorite: (() -> Void)?
    var index = 0
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setupCell()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }

}


extension PhotoplayTableViewCell {
    
    private func setupCell() {
        
        guard let isPhoto = photoPlay?.isPhoto else { return }
        btnPlay.isHidden = isPhoto
        
    }
    
}


extension PhotoplayTableViewCell {
    
    @IBAction func btnFavriteClicked() {
        
        markAsFavorite?()
        
    }
    
}
