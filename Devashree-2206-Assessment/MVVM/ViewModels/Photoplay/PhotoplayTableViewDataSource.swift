//
//  PhotoplayTableViewDataSource.swift
//  MVVM_New
//
//  Created by Abhilash Mathur on 20/05/20.
//  Copyright © 2020 Abhilash Mathur. All rights reserved.
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
