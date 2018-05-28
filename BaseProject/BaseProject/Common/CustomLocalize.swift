//
//  CustomLocalize.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import UIKit
import Localize_Swift
//CustomButton
class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLocalize()
    }
    
    func setLocalize() {
        if let title = title(for: .normal), !title.isEmpty {
            setTitle(title.localized(), for: state)
        }
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
}
//CustomTextField
class CustomTextField: UITextField {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        if let placeholder = placeholder , !placeholder.isEmpty {
            self.placeholder = placeholder.localized()
        }
        
        if let text = text , !text.isEmpty {
            self.text = text.localized()
        }
        
    }
    
}
//CustomLabel
class CustomLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let text = text, !text.isEmpty {
            self.text = text.localized()
        }
    }
    
}
//CustomTextView
class CustomTextView: UITextView {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        if let text = text , !text.isEmpty {
            self.text = text.localized()
        }
        
    }
    
}
