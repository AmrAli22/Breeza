//
//  Utilitis.swift
//  Damin
//
//  Created by Amr Ali on 17/08/2023.
//

import Foundation
import UIKit
import SafariServices
import CoreLocation
import MapKit
import FittedSheets
import Localize_Swift

class Utils {
    
    class func colorFor(percentage: Int) -> UIColor {
        
        switch percentage {
        case 0..<25:
            return UIColor(hexString: "#F24773")
        case 25..<50:
            return UIColor(hexString: "#F5E306")
        case 50..<75:
            return UIColor(hexString: "#00C6C1")
        case 75..<100:
            return UIColor(hexString: "#068DF5")
        default:
            return UIColor(hexString: "#007bff")
        }
        
    }
    class func getCurrentAppVersion() -> String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
    
    class func getAppVersionLong() -> String {
        return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
    }
    
    class func makeCall(phoneNumber: String) {
        let urlString = "telprompt://\(phoneNumber)"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    class func openWhatsApp(phoneNumber: String = "+966582320772") {
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:])
        }
    }
    
    class func openApp(url: String?) {
        
        let urlStr = ( url != nil ) ? url! : ""
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(URL(string: urlStr)!)
        }
    }
    
    class func openBrowser(link: String?) {
        if let link = link {
            guard let url = URL(string: link) else {
                return //be safe
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    class func share(textToShare: String, sourceView: UIView, vc: BaseVC) {
        
        // set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sourceView // so that iPads won't crash
        
        // present the view controller
        vc.present(activityViewController, animated: true, completion: nil)
        
    }
    
    class func shareImage(sharableImage: UIImage, sourceView: UIView, vc: BaseVC) {
        let activityViewController = UIActivityViewController(activityItems : [sharableImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sourceView
        
        vc.present(activityViewController, animated: true, completion: nil)
    }
    
    class func sendEmail(to: String) {
        let email = to
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    class func openMaps(latitude: Double, longitude: Double) {
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.openURL(NSURL(string:
                                                "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")! as URL)
        } else {
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = ""
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    class func getSafariPage(url: String) -> UIViewController? {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            return vc
        }
        return nil
    }
    
    public class func compareDates(date1: Date, date2: Date) -> DateComparisonResult {
        if date1 > date2 {
            return .FIRST_GREATER
        } else if date2 > date1 {
            return .SECOND_GREATER
        } else {
            return .EQUAL
        }
    }
    
    public class func convertDateToString(date: Date, dateFormat: String, locale: String = "en") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: locale)
        return formatter.string(from: date)
    }
    
    public class func convertStringToDate(string: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: Localize.currentLanguage())
        if let date = dateFormatter.date(from:string) {
            let calendar = Calendar.current
            let newDate = calendar.date(byAdding: .second, value: Utils.getDiffBetweenNowHereAndNowInGMT(), to: date)
            return newDate
        } else {
            return nil
        }
    }
    
    class func getDiffBetweenNowHereAndNowInGMT() -> Int {
        let now = Date()
        let timezoneOffset =  TimeZone.current.secondsFromGMT()
        let epochDate = now.timeIntervalSince1970
        let timezoneEpochOffset = (epochDate - Double(timezoneOffset))
        let nowInGMT = Date(timeIntervalSince1970: timezoneEpochOffset)

        return Int(now - nowInGMT)
    }
    
    class func convertImageToEncodedString(image: UIImage) -> String? {
        var imageData: String? = nil
        imageData = image.base64(format: .JPEG(0.2))
        if let base64 = imageData {
            imageData = "data:image/jpeg;base64,\(base64)"
        }
        return imageData
    }
    
    class func convertEncodedStringToImage(encodedString: String) -> UIImage? {
        if let decodedData = Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters) {
            return  UIImage(data: decodedData)
        }
        return nil
    }
    
    class func makeLabelUnderlined(label: UILabel) {
        let text = label.text
        let textRange = NSRange(location: 0, length: (text?.count)!)
        let attributedText = NSMutableAttributedString(string: text!)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        label.attributedText = attributedText
    }
    
    class func createSheetController(vc: BaseVC, sizes: [SheetSize] = []) -> SheetViewController {
        let sheetController = SheetViewController(controller: vc, sizes: sizes)
      //  sheetController.blurBottomSafeArea = true
      //  sheetController.adjustForBottomSafeArea = true
       // sheetController.topCornersRadius = 15
        return sheetController
    }
    
    static func getFormattedNumber(largeNumber:Double) -> String {
       let numberFormatter = NumberFormatter()
       numberFormatter.numberStyle = .decimal //
      return numberFormatter.string(from: NSNumber(value:largeNumber.rounded())) ?? ""
    }
    
    static func roundTo2Digits(number: Double) -> String {
        return String(format: "%.1f", number)
    }
}

public enum DateComparisonResult: Int {
    case FIRST_GREATER = 0
    case SECOND_GREATER = 1
    case EQUAL = 2
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension CGPoint {
     static let topLeft = CGPoint(x: 0, y: 0)
     static let topCenter = CGPoint(x: 0.5, y: 0)
     static let topRight = CGPoint(x: 1, y: 0)
static let centerLeft = CGPoint(x: 0, y: 0.5)
     static let center = CGPoint(x: 0.5, y: 0.5)
     static let centerRight = CGPoint(x: 1, y: 0.5)
static let bottomLeft = CGPoint(x: 0, y: 1.0)
     static let bottomCenter = CGPoint(x: 0.5, y: 1.0)
     static let bottomRight = CGPoint(x: 1, y: 1)
}

extension UIView {
    

    
    func gradient(startColor: UIColor, endColor: UIColor) {
        let gradient = CAGradientLayer()

        gradient.frame = bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]

        layer.insertSublayer(gradient, at: 0)
    }
    
    func addBottomRaduis(raduis: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = raduis
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
    func addBorderGradient(startColor:UIColor, endColor: UIColor, lineWidth: CGFloat, startPoint: CGPoint, endPoint: CGPoint) {
    //This will make view border circular
        self.layer.cornerRadius = self.bounds.size.height / 2.0
    //This will hide the part outside of border, so that it would look like circle
        self.clipsToBounds = true
    //Create object of CAGradientLayer
    let gradient = CAGradientLayer()
    //Assign origin and size of gradient so that it will fit exactly over circular view
    gradient.frame = self.bounds
    //Pass the gredient colors list to gradient object
    gradient.colors = [startColor.cgColor, endColor.cgColor]
    //Point from where gradient should start
    gradient.startPoint = startPoint
    //Point where gradient should end
    gradient.endPoint = endPoint
    //Now we have to create a circular shape so that it can be added to view’s layer
    let shape = CAShapeLayer()
    //Width of circular line
    shape.lineWidth = lineWidth
    //Create circle with center same as of center of view, with radius equal to half height of view, startAngle is the angle from where circle should start, endAngle is the angle where circular path should end
    shape.path = UIBezierPath(
    arcCenter: CGPoint(x: self.bounds.height/2,
    y: self.bounds.height/2),
    radius: self.bounds.height/2,
    startAngle: CGFloat(0),
    endAngle:CGFloat(CGFloat.pi * 2),
    clockwise: true).cgPath
    //the color to fill the path’s stroked outline
    shape.strokeColor = UIColor.black.cgColor
    //The color to fill the path
    shape.fillColor = UIColor.clear.cgColor
    //Apply shape to gradient layer, this will create gradient with circular border
    gradient.mask = shape
    //Finally add the gradient layer to out View
        self.layer.addSublayer(gradient)
    }
    
    
    
}



extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func width(constraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: .greatestFiniteMagnitude, height: height))
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.width
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
//            let style = NSMutableParagraphStyle()
//            if Localize.currentLanguage() == "en" {
//                style.alignment = NSTextAlignment.left
//            } else {
//                style.alignment = NSTextAlignment.right
//            }
            
            let htmlText = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//            htmlText.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, htmlText.length))

            return htmlText
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
