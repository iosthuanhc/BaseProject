//
//  CustomDropDown.swift
//  ThinkLabs_AQM
//
//  Created by Ha Cong Thuan on 5/17/18.
//  Copyright © 2018 ThinkLabs. All rights reserved.
//

import UIKit

protocol CustomDropDownDelegate: class {
    func didSelectItem(dropDown: CustomDropDown, at index: Int)  
    func didShow(dropDown: CustomDropDown) 
    func didHide(dropDown: CustomDropDown) 
    
}

extension CustomDropDownDelegate {
    func didSelectItem(dropDown: CustomDropDown, at index: Int) {
        
    }
    func didShow(dropDown: CustomDropDown)  {
        
    }
    func didHide(dropDown: CustomDropDown)  {
        
    }
}

@IBDesignable
class CustomDropDown: UIView {

    var delegate: CustomDropDownDelegate!
    fileprivate var label = UILabel()
    
    @IBInspectable
    var title : String {
        set {
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            label.text = newValue
        }
        get {
            return label.text!
        }
    }
    /*
     *    Sets the text size of onLabel. Defaults to UIFont.labelFontSize
     */
    @IBInspectable public var titleTextSize: CGFloat = UIFont.labelFontSize {
        willSet {
            label.font = UIFont(name: label.font.fontName, size: newValue)
        }
    }
    
    /*
     *   Set whether the text style is bold(on) or not(off). Defaults to not bold
     */
    @IBInspectable public var titleTextIsBold: Bool = false {
        willSet(isBold) {
            if isBold {
                label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
            } else {
                label.font = UIFont(name: label.font.fontName, size: label.font.pointSize)
            }
        }
    }

    @IBInspectable
    var textAllignment : NSTextAlignment {
        set {
            label.textAlignment = newValue
        }
        get {
            return label.textAlignment
        }
    }
    @IBInspectable
    var titleColor : UIColor {
        set {
            label.textColor = newValue
        }
        get {
            return label.textColor
        }
    }
    
    @IBInspectable
    var titleFont: UIFont {
        set {
            setTitleFont = newValue
            label.font = setTitleFont
        }
        get {
            return setTitleFont
        }
    }
    var setTitleFont: UIFont = .boldSystemFont(ofSize: 20)
    @IBInspectable
    var itemHeight : Double {
        get {
            return itemHeight1
        }
        set {
            itemHeight1 = newValue
        }
    }
    @IBInspectable
    var itemBackground : UIColor {
        set {
            itemBackgroundColor = newValue
        }
        get {
            return itemBackgroundColor
        }
    }
    fileprivate var selectedItemBackgroundColor = UIColor.white
    
    @IBInspectable
    var selectedItemBackground : UIColor {
        set {
            selectedItemBackgroundColor = newValue
        }
        get {
            return selectedItemBackgroundColor
        }
    }
    fileprivate var selectedItemTextColor = UIColor.white
    
    var selectedItemText : UIColor {
        set {
            selectedItemTextColor = newValue
        }
        get {
            return selectedItemTextColor
        }
    }
    
    fileprivate var itemBackgroundColor = UIColor.white
    @IBInspectable
    var itemTextColor : UIColor {
        set {
            itemFontColor = newValue
        }
        get {
            return itemFontColor
        }
    }
    fileprivate var itemFontColor = UIColor.black
    fileprivate var itemHeight1 = 40.0

    @IBInspectable
    var itemFont: UIFont {
        set {
            setItemFont = newValue
        }
        get {
            return setItemFont
        }
    }
    var setItemFont: UIFont = .systemFont(ofSize: 14)
    
    fileprivate var selectedFont = UIFont.systemFont(ofSize: 14)
    var items = [String]()
    fileprivate var selectedIndex = -1
    var selectedAccessoryType: UITableViewCellAccessoryType = .none
    
    var isCollapsed = true
    private var table = UITableView()
    
    var getSelectedIndex : Int {
        get {
            return selectedIndex
        }
    }
    
    private var tapGestureBackground: UITapGestureRecognizer!
    
    override func prepareForInterfaceBuilder() {
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        label.font = setTitleFont
        self.addSubview(label)
        textAllignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(label)
        textAllignment = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        self.addGestureRecognizer(tapGesture)
        table.delegate = self
        table.dataSource = self
        var rootView = self.superview
        // here we getting top superview to add table on that.
        while rootView?.superview != nil {
        rootView = rootView?.superview
       }
       let newFrame: CGRect = self.superview!.convert(self.frame, to: rootView)
      self.tableFrame = newFrame
      self.table.frame = CGRect(x: newFrame.origin.x, y: (newFrame.origin.y) + (newFrame.height)+5, width: (newFrame.width), height: 0)
        table.backgroundColor = itemBackgroundColor
    }
      // Default tableview frame
      var tableFrame = CGRect.zero
    
    @objc func didTapBackground(gesture: UIGestureRecognizer) {
        isCollapsed = true
        collapseTableView()
    }
    
    @objc private func didTap(gesture: UIGestureRecognizer) {
        isCollapsed = !isCollapsed
        if !isCollapsed {
            let height : CGFloat = CGFloat(items.count > 5 ? itemHeight*5 : itemHeight*Double(items.count))
            self.table.layer.zPosition = 1
            self.table.removeFromSuperview()
            self.table.layer.borderColor = UIColor.lightGray.cgColor
            self.table.layer.borderWidth = 1
            self.table.layer.cornerRadius = 1
            var rootView = self.superview
          // adding tableview to root view( we can say first view in hierarchy)
           while rootView?.superview != nil {
            rootView = rootView?.superview
          }
          rootView?.addSubview(self.table)
           self.table.reloadData()
            UIView.animate(withDuration: 0.25, animations: { 
                self.table.frame = CGRect(x: self.tableFrame.origin.x, y: self.tableFrame.origin.y + self.frame.height+5, width: self.frame.width, height: height)
              
            })
            if delegate != nil {
                delegate.didShow(dropDown: self)
            }
            let view = UIView(frame: UIScreen.main.bounds)
            view.tag = 99121
            self.superview?.insertSubview(view, belowSubview: table)
            tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(didTapBackground(gesture:)))
            view.addGestureRecognizer(tapGestureBackground)
        }
        else {
            collapseTableView()
        }
        
    }
    
    func collapseTableView() {
        if isCollapsed {
            // removing tableview from rootview
        UIView.animate(withDuration: 0.25, animations: { 
                self.table.frame = CGRect(x: self.tableFrame.origin.x, y: self.tableFrame.origin.y+self.frame.height, width: self.frame.width, height: 0)
            })
          var rootView = self.superview
          while rootView?.superview != nil {
             rootView = rootView?.superview
          }
          rootView?.viewWithTag(99121)?.removeFromSuperview()
            self.superview?.viewWithTag(99121)?.removeFromSuperview()
            if delegate != nil {
                delegate.didHide(dropDown: self)
            }
        }
    }
}

extension CustomDropDown : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.textAlignment = textAllignment
        cell?.textLabel?.text = items[indexPath.row]
        cell?.textLabel?.font = setItemFont
        if indexPath.row == selectedIndex {
            cell?.backgroundColor = selectedItemBackground
            cell?.accessoryType = selectedAccessoryType
            cell?.textLabel?.textColor = selectedItemTextColor
        } else {
            cell?.backgroundColor = itemBackgroundColor
            cell?.textLabel?.textColor = itemTextColor
            cell?.accessoryType = .none
        }
        cell?.tintColor = self.tintColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(itemHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        label.text = items[selectedIndex]
        isCollapsed = true
        collapseTableView()
        if delegate != nil {
            delegate.didSelectItem(dropDown: self, at: selectedIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
