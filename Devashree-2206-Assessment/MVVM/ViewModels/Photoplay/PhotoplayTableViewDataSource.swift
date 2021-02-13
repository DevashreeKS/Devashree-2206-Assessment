//
//  PhotoplayTableViewDataSource.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import Foundation
import UIKit

class PhotoplayTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    // MARK: - Variables
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T, Int) -> () = {_,_,_ in }
    
    
    // MARK: - Overrides
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T, Int) -> ()) {
       
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    
    }
    
    
    // MARK: - Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        items.count
    
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.row]
        self.configureCell(cell, item, indexPath.row)
        return cell
   
    }
    
}
