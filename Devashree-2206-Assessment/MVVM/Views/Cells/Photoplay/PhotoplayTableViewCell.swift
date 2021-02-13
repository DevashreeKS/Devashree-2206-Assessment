//
//  PhotoplayTableViewCell.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
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
