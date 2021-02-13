//
//  UIViewControllerExtension.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 12/02/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title : String, msg : String) {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        let ac = UIAlertController.init(title: title,
                                        message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default, handler: nil))
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        DispatchQueue.main.async {
            rootViewController?.present(ac, animated: true, completion: nil)
        }
    }
    
}
