//
//  ViewController.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 12/02/21.
//

import UIKit
import SwiftyJSON
import Nuke

class PhotoplayController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var photoplayTableView: UITableView!
    
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var viewSearch: UISearchBar!
    
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var btnFavorites: UIButton!
    
    @IBOutlet weak var lineViewPhoto: UIView!
    @IBOutlet weak var lineViewVideo: UIView!
    @IBOutlet weak var lineViewFavrites: UIView!
    
    
    // MARK: - Variables
    
    private var photoplayViewModel : PhotoplayViewModel!
    private var dataSource : PhotoplayTableViewDataSource<PhotoplayTableViewCell, JSON>!
    private var delegate : PhotoplayTableViewDelegate<PhotoplayTableViewCell>!
    

    // MARK: - Overrides
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        callToViewModelForUIUpdate()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        photoplayViewModel.updatePhotoplayType(.photo)
        
    }
    
    
    func nextVC(index: Int) {

        navigationController?.pushViewController(photoplayViewModel.nextVC(index: index), animated: true)

    }

}

// MARK: - Custom methods

extension PhotoplayController {
    
    func callToViewModelForUIUpdate() {
        
        photoplayViewModel =  PhotoplayViewModel()
        photoplayViewModel.delegate = self
        photoplayViewModel.callPexelsAPI(StringConstants.defaultSearch)
        updateDelegate()
        
        photoplayViewModel.bindPhotoplayViewModelToController = {
            self.updateData()
        }
        
    }
    
    
    private func callAPIs(text: String = "") {
        
        switch photoplayViewModel.photoPlayViewType {
        case .photo:
            photoplayViewModel.callPexelsAPI(text)
        case .video:
            photoplayViewModel.callPexelsAPI(text)
        case .favorites:
            updateDataSourceForFavorites()
        }
        
    }
    
    
    private func updateData() {
        switch photoplayViewModel.photoPlayViewType {
        case .photo:
            updateDataSourceForPhotos()
        case .video:
            updateDataSourceForVideos()
        case .favorites:
            updateDataSourceForFavorites()
        }
    }
    
    
    private func updateDataSourceForPhotos() {
        
        guard let items = photoplayViewModel.photoItem() else { return }
        dataSource = PhotoplayTableViewDataSource(
            cellIdentifier: StringConstants.StoryboardIdentifiers.Cells.photoPlayCell,
            items: items, configureCell: { (cell, evm, index) in
            
            cell.lblName.text = evm.dictionary?[StringConstants.APIParams.photographer]?.string
            cell.btnIsFavourite.isSelected = self.photoplayViewModel.isFavorite(
                id: evm.dictionary?[StringConstants.APIParams.id]?.intValue)
            cell.index = index
            cell.photoPlay = self.photoplayViewModel.photosData
            guard let url = URL(
                    string: evm.dictionary?[StringConstants.APIParams.src]?[StringConstants.APIParams.medium].string
                        ?? "") else { return }
            let options = ImageLoadingOptions(
                placeholder: UIImage.imageFromColor(UIColor(hexValue: lighttheme)),
                transition: .fadeIn(duration: 0.33)
            )
            Nuke.loadImage(with: URLRequest(url: url), options: options, into: cell.bgImageView)
            
            cell.markAsFavorite = {
                self.photoplayViewModel.updateFavoriteStatus(
                    id: evm.dictionary?[StringConstants.APIParams.id]?.intValue)
            }
            
        })
        
        DispatchQueue.main.async {
            self.photoplayTableView.dataSource = self.dataSource
            self.photoplayTableView.reloadData()
        }
        
    }
    
    
    private func updateDataSourceForVideos() {
        
        guard let items = photoplayViewModel.videoItem() else { return }
        dataSource = PhotoplayTableViewDataSource(
            cellIdentifier: StringConstants.StoryboardIdentifiers.Cells.photoPlayCell, items: items,
            configureCell: { (cell, evm, index) in
            
            cell.index = index
//            cell.lblName.text = evm.dictionary?[StringConstants.APIParams.photographer]?.string
//            cell.btnIsFavourite.isSelected = self.photoplayViewModel.isFavorite(id: evm.dictionary?[StringConstants.APIParams.id]?.string ?? "")
//
//            guard let url = URL(string: evm.dictionary?[StringConstants.APIParams.src]?[StringConstants.APIParams.medium].string ?? "") else { return }
//            let options = ImageLoadingOptions(
//                placeholder: UIImage.imageFromColor(UIColor(hexValue: lighttheme)),
//                transition: .fadeIn(duration: 0.33)
//            )
//            Nuke.loadImage(with: URLRequest(url: url), options: options, into: cell.bgImageView)
//
//            cell.markAsFavorite = {
////                self.photoplayViewModel
//            }
            
        })
        
        DispatchQueue.main.async {
            self.photoplayTableView.dataSource = self.dataSource
            self.photoplayTableView.reloadData()
        }
        
    }
    
    
    private func updateDataSourceForFavorites() {
        
        guard let items = photoplayViewModel.favouriteItem() else { return }
        dataSource = PhotoplayTableViewDataSource(
            cellIdentifier: StringConstants.StoryboardIdentifiers.Cells.photoPlayCell,
            items: items, configureCell: { (cell, evm, index) in
            
            if self.photoplayViewModel.isFavorite(id: evm.dictionary?[StringConstants.APIParams.id]?.intValue) {
                cell.lblName.text = evm.dictionary?[StringConstants.APIParams.photographer]?.string
                cell.btnIsFavourite.isSelected = self.photoplayViewModel.isFavorite(id: evm.dictionary?[StringConstants.APIParams.id]?.intValue)

                guard let url = URL(
                        string: evm.dictionary?[StringConstants.APIParams.src]?[StringConstants.APIParams.medium].string
                            ?? "") else { return }
                let options = ImageLoadingOptions(
                    placeholder: UIImage.imageFromColor(UIColor(hexValue: lighttheme)),
                    transition: .fadeIn(duration: 0.33)
                )
                Nuke.loadImage(with: URLRequest(url: url), options: options, into: cell.bgImageView)

                cell.markAsFavorite = {
                    self.photoplayViewModel.updateFavoriteStatus(
                        id: evm.dictionary?[StringConstants.APIParams.id]?.intValue)
                }
            }
            
        })
        
        DispatchQueue.main.async {
            self.photoplayTableView.dataSource = self.dataSource
            self.photoplayTableView.reloadData()
        }
        
    }
    
    
    private func updateDelegate() {
        
        delegate = PhotoplayTableViewDelegate(cellIdentifier: StringConstants.StoryboardIdentifiers.Cells.photoPlayCell)
        
        DispatchQueue.main.async {
            self.photoplayTableView.delegate = self.delegate
            self.photoplayTableView.reloadData()
        }
        
        delegate.didSelect = {
            
            self.nextVC(index: $0)
            
        }
    }
    
}

// MARK: - PhotoplayViewModelDelegate

extension PhotoplayController: PhotoplayViewModelDelegate {
    
    func presentError(title: String, message: String) {
        DispatchQueue.main.async { self.showAlert(title: title, msg: message) }
    }
    
    
    func handleLoader(_ shouldShow: Bool) {
        DispatchQueue.main.async {
            shouldShow ? self.view.showDefaultActivityIndicator() : self.view.hideDefaultActivityIndicator()
        }
    }
    
    
    func updateLineColor(_ type: PhotoplayViewType) {
        
        updateButtonSelection(type)
        updateLineColor(lineViewPhoto, btnPhoto.isSelected)
        updateLineColor(lineViewVideo, btnVideo.isSelected)
        updateLineColor(lineViewFavrites, btnFavorites.isSelected)
    
    }
    
}


// MARK: - IBActions

extension PhotoplayController {
    
    @IBAction func btnPhotoClicked() {
        
        photoplayViewModel.updatePhotoplayType(.photo)
        updateData()
        
    }
    
    
    @IBAction func btnVideoClicked() {
        
        photoplayViewModel.updatePhotoplayType(.video)
        updateData()
        
    }
    
    
    @IBAction func btnFavritesClicked() {
        
        photoplayViewModel.updatePhotoplayType(.favorites)
        updateData()
        
    }
    
    
    @IBAction func btnSearchClicked() {
        
        guard let searchString = viewSearch.text else { return }
        photoplayViewModel.callPexelsAPI(searchString)
        
    }
    
}

// MARK: - Custom methods

extension PhotoplayController {
    
    private func setupView() {
        
        viewNavigation.backgroundColor = .clear
        btnSearch.isHidden = true
        
    }
    
    
    private func updateButtonSelection(_ type: PhotoplayViewType) {
        
        btnPhoto.isSelected = type == .photo
        btnVideo.isSelected = type == .video
        btnFavorites.isSelected = type == .favorites
        
    }
    
    
    private func updateLineColor(_ lineView: UIView, _ isSelected: Bool) {
        
        lineView.backgroundColor = photoplayViewModel.lineColor(isSelected)
        
    }
    
}


// MARK: - Custom methods

extension PhotoplayController: UISearchBarDelegate {
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        callAPIs(text: searchBar.text ?? "")
        
    }
    
}
