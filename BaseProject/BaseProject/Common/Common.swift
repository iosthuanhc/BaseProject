//
//  Common.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
import UIKit

class Common {
    class func setBadgeValue(tab: UITabBarController, value: Int = 0, inTabarIndex: Int ) {
        if let tabItems = tab.tabBar.items as NSArray?, value > 0 {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[inTabarIndex] as! UITabBarItem
            tabItem.badgeValue = "\(value)"
        }
        UIApplication.shared.applicationIconBadgeNumber = value
    }
    
    class func instanceFromNib(nibName: String!) -> UIView? {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    class func showSingleAlert(parent: UIViewController, title: String, message: String, titleButton: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: titleButton, style: UIAlertActionStyle.default, handler: nil))
        parent.present(alert, animated: true, completion: nil)
    }
    
    class func validateEmail(input:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input)
    }
    
    class func convertDate(date: String, dateFormat: String) -> DateComponents{
        let dateFormatter = DateFormatter()
        let userCalendar = Calendar.current
        let requestedComponent: Set<Calendar.Component> = [.year,.month,.day,.hour,.minute,.second]
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
        let startTime = dateFormatter.date(from:date )
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime!, to:  Date()
        )
        return timeDifference
    }
    
    class func showTimeBefore(date: String, format: String) -> String {
        let dateCom = Common.convertDate(date: date, dateFormat: format)
        var showTime = ""
        if dateCom.year != 0 {
            showTime = "\(dateCom.year ?? 0) năm trước"
        } else if dateCom.month != 0 {
            showTime = "\(dateCom.month ?? 0) tháng trước"
        } else if dateCom.day != 0 {
            showTime = "\(dateCom.day ?? 0) ngày trước"
        } else if dateCom.hour != 0 {
            showTime = "\(dateCom.hour ?? 0) giờ trước"
        } else if dateCom.minute != 0 {
            showTime = "\(dateCom.minute ?? 0) phút trước"
        } else if dateCom.second != 0 {
            showTime = "\(dateCom.second ?? 0) giây trước"
        } else {
            showTime = " vừa xong"
        }
        return showTime
    }
    
     class func UTCToLocal(date: String, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dt!)
    }
}
