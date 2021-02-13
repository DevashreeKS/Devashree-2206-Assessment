//
//  UIImageExtension.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 13/02/21.
//

import UIKit

extension UIImage {

    static func imageFromColor(_ color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError("Something went wrong")
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("Something went wrong")
        }
        UIGraphicsEndImageContext()
        return image
        
    }
}
