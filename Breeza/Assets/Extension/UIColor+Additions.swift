//
//  UIColor+Additions.swift
//  inSchool
//
//  Created by MohamedKhalid on 3/11/19.
//  Copyright © 2019 Mohamed Khalid. All rights reserved.
//


import UIKit

extension UIColor {
//    convenience init(hexString: String, alpha: CGFloat = 1.0) {
//        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let scanner = Scanner(string: hexString)
//        if (hexString.hasPrefix("#")) {
//            scanner.scanLocation = 1
//        }
//        var color: UInt32 = 0
//        scanner.scanHexInt32(&color)
//        let mask = 0x000000FF
//        let r = Int(color >> 16) & mask
//        let g = Int(color >> 8) & mask
//        let b = Int(color) & mask
//        let red = CGFloat(r) / 255.0
//        let green = CGFloat(g) / 255.0
//        let blue = CGFloat(b) / 255.0
//        self.init(red:red, green:green, blue:blue, alpha:alpha)
//    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    
    //rgb 74 74 74
    class var iscDarkGrey: UIColor {
        return UIColor(red: 74 / 255, green: 74 / 255, blue: 74 / 255, alpha: 1.0)
    }
    
    class var iscDarkGrey29Opacity: UIColor {
        return UIColor(red: 74 / 255, green: 74 / 255, blue: 74 / 255, alpha: 0.29)
    }
    
    class var iscGreen: UIColor {
        return UIColor(red: 0 / 255, green: 173 / 255, blue: 42 / 255, alpha: 1.0)
    }
    
    class var tabGreyColor: UIColor {
        return UIColor(red: 210 / 255, green: 214 / 255, blue: 213 / 255, alpha: 1.0)
    }
    
    class var mainAppColor: UIColor {
        return UIColor(red: 244 / 255, green: 247 / 255, blue: 246 / 255, alpha: 1.0)
    }

}
