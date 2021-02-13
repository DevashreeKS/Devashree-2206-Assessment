//
//  PhotoplayTableViewDelegate.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import Foundation
import UIKit

class PhotoplayTableViewDelegate<CELL : UITableViewCell> : NSObject, UITableViewDelegate {
    
    // MARK: - Variables
    
    private var cellIdentifier : String!
    var didSelect: ((Int) -> Void)?
    
    
    // MARK: - Overrides
    
    init(cellIdentifier : String) {
    
        self.cellIdentifier = cellIdentifier
    
    }
    
    
    // MARK: - Tableview
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
