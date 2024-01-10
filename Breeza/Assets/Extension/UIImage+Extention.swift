//
//  UIImage+Extention.swift
//  bravoStore
//
//  Created by SOLIMAN on 6/18/20.
//  Copyright © 2020 Thimar Shops. All rights reserved.
//

import UIKit
import Kingfisher

public enum ImageFormat {
    case PNG
    case JPEG(CGFloat)
}

extension UIImage {
    
   static func downloadImage(url: String?, completion: ((UIImage) -> Void)?) {

        guard var stringURL = url else { return }
        stringURL = stringURL.safeUrl()
        guard let url = URL(string: stringURL) else { return }
        let resource = KF.ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource,
                                               options: [.forceRefresh], progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion?(value.image)

            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }

    func resizeImage(targetSize: CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func base64(format: ImageFormat) -> String {
        var imageData: Data
        switch format {
        case .PNG: imageData = (self.pngData())!
        case .JPEG(let compression): imageData = self.jpegData(compressionQuality: compression)!
        }
        let base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0
        ))
        return base64String
    }
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
            guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
                print("image doesn't exist")
                return nil
            }
            
            return UIImage.animatedImageWithSource(source)
        }
        
        public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
            guard let bundleURL:URL? = URL(string: gifUrl)
                else {
                    print("image named \"\(gifUrl)\" doesn't exist")
                    return nil
            }
            guard let imageData = try? Data(contentsOf: bundleURL!) else {
                print("image named \"\(gifUrl)\" into NSData")
                return nil
            }
            
            return gifImageWithData(imageData)
        }
        
        public class func gifImageWithName(_ name: String) -> UIImage? {
            guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
                    print("SwiftGif: This image named \"\(name)\" does not exist")
                    return nil
            }
            guard let imageData = try? Data(contentsOf: bundleURL) else {
                print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
                return nil
            }
            
            return gifImageWithData(imageData)
        }
        
        class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
            var delay = 0.1
            
            let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
            let gifProperties: CFDictionary = unsafeBitCast(
                CFDictionaryGetValue(cfProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
                to: CFDictionary.self)
            
            var delayObject: AnyObject = unsafeBitCast(
                CFDictionaryGetValue(gifProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
                to: AnyObject.self)
            if delayObject.doubleValue == 0 {
                delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
            }
            
            delay = delayObject as! Double
            
            if delay < 0.1 {
                delay = 0.1
            }
            
            return delay
        }
        
        class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
            var a = a
            var b = b
            if b == nil || a == nil {
                if b != nil {
                    return b!
                } else if a != nil {
                    return a!
                } else {
                    return 0
                }
            }
            
            if a ?? 0 < b ?? 0 {
                let c = a
                a = b
                b = c
            }
            
            var rest: Int
            while true {
                rest = a! % b!
                
                if rest == 0 {
                    return b!
                } else {
                    a = b
                    b = rest
                }
            }
        }
        
        class func gcdForArray(_ array: Array<Int>) -> Int {
            if array.isEmpty {
                return 1
            }
            
            var gcd = array[0]
            
            for val in array {
                gcd = UIImage.gcdForPair(val, gcd)
            }
            
            return gcd
        }
        
        class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
            let count = CGImageSourceGetCount(source)
            var images = [CGImage]()
            var delays = [Int]()
            
            for i in 0..<count {
                if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(image)
                }
                
                let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                    source: source)
                delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
            }
            
            let duration: Int = {
                var sum = 0
                
                for val: Int in delays {
                    sum += val
                }
                
                return sum
            }()
            
            let gcd = gcdForArray(delays)
            var frames = [UIImage]()
            
            var frame: UIImage
            var frameCount: Int
            for i in 0..<count {
                frame = UIImage(cgImage: images[Int(i)])
                frameCount = Int(delays[Int(i)] / gcd)
                
                for _ in 0..<frameCount {
                    frames.append(frame)
                }
            }
            
            let animation = UIImage.animatedImage(with: frames,
                duration: Double(duration) / 1000.0)
            
            return animation
        }
}



// MARK: - SwifterSwift

public extension UIImage {
    
    /// SwifterSwift: Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0.
    //The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression
    //(or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }
    
    /// SwifterSwift: Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0.
    //The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression
    //(or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return self.jpegData(compressionQuality: quality)
    }
}
