//
//  UITextField+Additions.swift
//  inSchool
//
//  Created by Ahmad Adel Mostafa El-Kilany on 7/7/19.
//  Copyright © 2019 Mohamed Khalid. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func setPadding(by value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setBottomBorder(x: CGFloat = 0, widthToDecrease: CGFloat = 0) {
        self.layer.shadowColor = UIColor(red: 198.0 / 255, green: 198.0 / 255, blue: 198.0 / 255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: x, y: self.frame.height - 1, width: self.frame.width - x - widthToDecrease, height: 1)).cgPath
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
    func setupRightImage(imageName:String){
      let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
      imageView.image = UIImage(named: imageName)
      let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
      imageContainerView.addSubview(imageView)
      rightView = imageContainerView
      rightViewMode = .always
      self.tintColor = .lightGray
  }

   //MARK:- Set Image on left of text fields

      func setupLeftImage(imageName:String){
         let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
         imageView.image = UIImage(named: imageName)
         let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
         imageContainerView.addSubview(imageView)
         leftView = imageContainerView
         leftViewMode = .always
         self.tintColor = .lightGray
       }
}
