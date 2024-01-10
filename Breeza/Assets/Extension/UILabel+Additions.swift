//
//  UILabel+Additions.swift
//  inSchool
//
//  Created by MohamedKhalid on 3/11/19.
//  Copyright © 2019 Mohamed Khalid. All rights reserved.
//
import UIKit
extension UILabel {
    
    func adjustFontSize(with relativeFontConstant: CGFloat){
        adjustsFontSizeToFitWidth = true
        font = font.withSize(frame.width * relativeFontConstant)
    }
}
