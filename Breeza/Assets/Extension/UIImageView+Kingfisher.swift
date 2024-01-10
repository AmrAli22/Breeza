//
//  UIImageView+Kingfisher.swift
//  QDPM-Muzaf
//
//  Created by Alaa Eid on 16/07/2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {

    
    func fromURL(_ stringUrl:String?) {
        guard let stringURL = stringUrl else { return }
        
        // get remote image from url
        if let url = URL(string: stringURL.safeUrl()) {
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: UIImage(named: "logo"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.25)),
                    .cacheOriginalImage
                ])
        }
        
    }
    
    
}
