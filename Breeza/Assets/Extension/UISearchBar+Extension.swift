//
//  UISearchBar+Extension.swift
//  QDPM-Muqawel
//
//  Created by Alaa Eid on 07/06/2023.
//

import UIKit

extension UISearchBar {

    func setupDefaultAppearance(){
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "Cairo-Regular", size: 16)
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor(hexString: "#CCCCCC")
        
        self.backgroundColor = .clear
        self.backgroundImage = UIImage()
        self.tintColor = UIColor(hexString: "#CCCCCC")
        
        self.searchTextField.textColor = UIColor(hexString: "#121928")
        self.searchTextField.font = UIFont(name: "Cairo-Regular", size: 16)
        self.searchTextField.backgroundColor = .white
        self.searchTextField.borderColor = UIColor(hex: "#F4F6FA")
        self.searchTextField.borderWidth = 1
        self.searchTextField.cornerRadius = 10
        self.searchTextField.layer.masksToBounds = true
        
        self.setImage(UIImage(named: "search"),
                      for: .search, state: .normal)
        //                self.setImage(UIImage(), for: .clear, state: .normal)
        //        self.searchTextField.borderStyle = .none
        //        self.searchTextField.fillSuperview(padding: UIEdgeInsets(top: 0, left: -9, bottom: 0, right: 0))
    }



}
