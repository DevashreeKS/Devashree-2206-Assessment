//
//  ColorExtension.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 12/02/21.
//

import UIKit

extension UIColor {

    /**
     Convenience initialiser to creat UIColor from integer RGB values.

     - parameter red: red component from 0 to 255
     - parameter green: green component from 0 to 255
     - parameter blue: blue component from 0 to 255
     - parameter alpha: opacity value from 0 to 100. Default is 100
     */
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {

        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }

    /**
     Convenience initialiser to creat UIColor from hexadecimal value.

     - parameter hexValue: hexadeciam;l value e.g. 0xFFFFFF
    */
    convenience init(hexValue: Int, alpha: CGFloat = 1.0) {
        self.init(red: (hexValue >> 16) & 0xff,
                      green: (hexValue >> 8) & 0xff,
                      blue: hexValue & 0xff,
                      alpha: alpha)
    }
}
