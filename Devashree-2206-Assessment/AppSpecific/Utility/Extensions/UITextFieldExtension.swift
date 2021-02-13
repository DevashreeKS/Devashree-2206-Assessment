//
//  AppDelegate.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//


import Foundation
import UIKit

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector, datePickerMode: UIDatePicker.Mode, initialDate: Date?) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 100, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = datePickerMode //2
        self.inputView = datePicker //3
        datePicker.date = initialDate ?? Date()
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
