//
//  PhotoplayViewModel.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import Foundation
import UIKit
import SwiftyJSON


enum PhotoplayViewType {
    case photo
    case video
    case favorites
}


protocol PhotoplayViewModelDelegate: ViewModelDelegate {
    
    func presentError(title: String, message: String)
    func handleLoader(_ shouldShow: Bool)
    func updateLineColor(_ type: PhotoplayViewType)
    
}

class PhotoplayViewModel : NSObject {
    
    // MARK: - Variables
    
    private var apiService : APIService!
    var photosData : PhotoplayModel! {
        didSet {
            self.bindPhotoplayViewModelToController()
        }
    }
    var photoPlayViewType: PhotoplayViewType = .photo {
        didSet {
            delegate?.updateLineColor(photoPlayViewType)
        }
    }
    
    var bindPhotoplayViewModelToController : (() -> ()) = {}
    weak var delegate: PhotoplayViewModelDelegate?
    
    // MARK: - Overrides
    
    override init() {
        
        super.init()
        self.apiService =  APIService()
        
    }
    
}

// MARK: - Custom methods

extension PhotoplayViewModel {
    
    func updatePhotoplayType(_ type: PhotoplayViewType) {
       
        photoPlayViewType = type
    
    }
    
    
    func lineColor(_ isSelected: Bool) -> UIColor {
        
        isSelected ? UIColor(hexValue: theme) : .clear
        
    }
    
    
    func photoItem() -> [JSON]? {
        
        photosData.data[StringConstants.APIParams.photos].array
    
    }
    
    
    func videoItem() -> [JSON]? {
        
        photosData.videoData[StringConstants.APIParams.photos].array
    
    }
    
    
    func favouriteItem() -> [JSON]? {
        var item: [JSON] = [JSON()]
        item = photosData.data[StringConstants.APIParams.photos].array?.filter {
            photosData.favoriteIds.contains($0.dictionary?[StringConstants.APIParams.id]!.intValue ?? 0)
        } ?? []
        return item
    
    }
    
    
    func updateFavoriteStatus(id: Int?) {
        
        guard let i = id else { return }
        if photosData.favoriteIds.contains(i) {
            if let item = photosData.favoriteIds.firstIndex(of: i) {
                photosData.favoriteIds.remove(at: item)
            }
        } else {
            photosData.favoriteIds.append(i)
        }
        
    }
    
    
    func isFavorite(id: Int?) -> Bool {
        
        guard let i = id else { return false }
        return photosData.favoriteIds.contains(i)
        
    }
    
    
    func nextVC(index: Int) -> PhotoplayDetailController {
        let storyBoard : UIStoryboard = UIStoryboard(name: StringConstants.StoryboardIdentifiers.Storyboards.main, bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(
            withIdentifier: StringConstants.StoryboardIdentifiers.Storyboards.detailVC) as! PhotoplayDetailController
        nextViewController.photoplayViewModel.photosData = photosData
        nextViewController.photoplayViewModel.i = index
        nextViewController.photoplayViewModel.photoPlayViewType = photosData.type
        return nextViewController
    }
    
}

// MARK: - API calls

extension PhotoplayViewModel {
    
    func callPexelsAPI(_ searchString: String = StringConstants.defaultSearch) {
       
        if Reachability.isConnectedToNetwork() {
            delegate?.handleLoader(true)
            self.apiService.getPhotos(query: searchString) { (result) in
                self.delegate?.handleLoader(false)
//                if self.photosData.videoData != nil {
//                    self.photosData = PhotoplayModel(type: .photo, data: result, videoData: self.photosData.videoData, favoriteIds: self.photosData.favoriteIds)
//                } else {
                self.photosData = PhotoplayModel(type: .photo, data: result)
//                }
            } failure: { (error) in
                self.delegate?.handleLoader(false)
                self.delegate?.handleCommonAPIError(error: .invalidRequest)
            }

        } else {
            delegate?.handleCommonAPIError(error: .noInternet)
        }
    
    }
    
    
    func callPexelsAPIForVideos(_ searchString: String = StringConstants.defaultSearch) {
       
        if Reachability.isConnectedToNetwork() {
            delegate?.handleLoader(true)
            self.apiService.getPhotos(query: searchString) { (result) in
                self.delegate?.handleLoader(false)
                self.photosData = PhotoplayModel(type: .video, data: self.photosData.data, videoData: result, favoriteIds: self.photosData.favoriteIds)
            } failure: { (error) in
                self.delegate?.handleLoader(false)
                self.delegate?.handleCommonAPIError(error: .invalidRequest)
            }

        } else {
            delegate?.handleCommonAPIError(error: .noInternet)
        }
    
    }
    
}
