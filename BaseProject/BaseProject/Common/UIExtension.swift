//
//  UIExtension.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryBoard : String {
    case main = "Main"
}

extension UIViewController {
    
    class func instantiateControllerWith<T: UIViewController>(appStoryboard: AppStoryBoard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return (storyboard.instantiateViewController(withIdentifier: identifier) as? T)!
    }
}

extension UIStoryboard {
    class func viewControllerFor(storyboardName: String, storyboardId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardId)
    }
    
}

extension UITextField {
    
    override open func becomeFirstResponder() -> Bool {
        layer.borderColor = borderColor?.cgColor
        layer.masksToBounds = true
        layer.borderWidth = 1
        super.becomeFirstResponder()
        return true
    }
    
    override open func resignFirstResponder() -> Bool {
        layer.masksToBounds = true
        layer.borderWidth = 0
        super.resignFirstResponder()
        return true
    }
    
}
class DesignableView: UIView {
}

@IBDesignable class DesignableButton: UIButton {
}

@IBDesignable class DesignableLabel: UILabel {
}

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowColor: UIColor? {
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
}
