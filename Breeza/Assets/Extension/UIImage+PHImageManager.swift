//
//  UIImage+PHImageManager.swift
//  QDPM-Muzaf
//
//  Created by Alaa Eid on 10/04/2023.
//

import Foundation
import UIKit
import Photos

extension PHAsset {

    var image : UIImage {
        var thumbnail = UIImage()
        
        let options = PHImageRequestOptions()
        // Enables gettings iCloud photos over the network, this means PHImageResultIsInCloudKey will never be true.
        options.isNetworkAccessAllowed = true
        // Get 2 results, one low res quickly and the high res one later.
        options.deliveryMode = .opportunistic
        
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: self.pixelWidth, height: self.pixelHeight),
                                  contentMode: .aspectFit, options: options, resultHandler: { image, _ in
            if let image = image {
                thumbnail = image
            } else {
                assertionFailure("Can't find image!")
            }
         
        })
        return thumbnail
    }
    
}


extension PHCachingImageManager {

    
    /// This method return two images in the callback. First is with low resolution, second with high.
    /// So the callback fires twice.
    func fetch(photo asset: PHAsset, callback: @escaping (UIImage, Bool) -> Void) {
        let options = PHImageRequestOptions()
        // Enables gettings iCloud photos over the network, this means PHImageResultIsInCloudKey will never be true.
        options.isNetworkAccessAllowed = true
        // Get 2 results, one low res quickly and the high res one later.
        options.deliveryMode = .opportunistic
        
//        options.isSynchronous = true

        
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
                         contentMode: .aspectFill, options: options) { result, info in
                guard let image = result else {
                    print("No Result 🛑")
                    return
                }
                DispatchQueue.main.async {
                    let isLowRes = (info?[PHImageResultIsDegradedKey] as? Bool) ?? false
                    callback(image, isLowRes)
                }
            }
        }
    }
}
