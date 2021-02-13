//
//  AppDelegate.swift
//  Devashree-2206-Assessment
//
//  Created by Devashree KS on 12/02/21.
//

import Foundation
import UIKit

// MARK: - UIView extension

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }
    
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }
    
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }
    
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    func addTapGesture(tapNumber : Int, target: Any , action : Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
    }
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    
    }

    
    @objc func dismissKeyboard() {
    
        self.endEditing(true)
    
    }
    
    
    func showDefaultActivityIndicator(shouldDisableUserInteraction: Bool = false) {
      
        self.removeAnyOldActivityIndicators()
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        activityIndicator.color = UIColor.gray
        self.addSubview(activityIndicator)
        self.bringSubviewToFront(activityIndicator)
        self.isUserInteractionEnabled = !shouldDisableUserInteraction
        activityIndicator.startAnimating()
   
    }
    

    func hideDefaultActivityIndicator() {

        for subview in self.subviews {
            if let indicator = subview as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
        self.isUserInteractionEnabled = true
   
    }
    

    fileprivate func removeAnyOldActivityIndicators() {
     
        for subview in self.subviews {
            if let indicator = subview as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
        
    }
    
}


// MARK: - CircularView

@IBDesignable
class CircularView: UIView {
    
    @IBInspectable var circular : Bool = false {
        didSet {
            self.applyCornerRadius()
        }
    }
    
    
    func applyCornerRadius() {
        if (self.circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor?.cgColor
            self.layer.borderWidth = self.borderWidth
        } else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor?.cgColor
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCornerRadius()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
    
}
