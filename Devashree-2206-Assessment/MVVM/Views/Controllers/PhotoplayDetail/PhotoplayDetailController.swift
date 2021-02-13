//
//  PhotoplayDetailViewController.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import UIKit

class PhotoplayDetailController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnFavrite: UIButton!
    @IBOutlet weak var btnZoomIn: UIButton!
    @IBOutlet weak var btnZoomOut: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    
    // MARK: - Variables
    
    var photoplayViewModel : PhotoplayDetailViewModel!
    

    // MARK: - Overrides
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        
    }

}

//MARK: - Custom methods

extension PhotoplayDetailController {
    
    private func setupView() {
        
    }
    
}


//MARK: - IBActions

extension PhotoplayDetailController {
    
    @IBAction func btnBackClicked() {
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    @IBAction func btnMoreClicked() {}
    
    
    @IBAction func btnFavriteClicked() {}
    
    
    @IBAction func btnZoomInClicked() {}
    
    
    @IBAction func btnZoomoutClicked() {}
    
}
