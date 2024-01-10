//
//  Utilities.swift
//  Mustafid
//
//  Created by Amr Ali on 04/09/2022.
//
import Foundation
import UIKit
import Localize_Swift
import FittedSheets

class Utilities {
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

//    class func openMaps(latitude: Double, longitude: Double) {
//        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
//            UIApplication.shared.openURL(NSURL(string:
//                                                "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")! as URL)
//        } else {
//            let regionDistance:CLLocationDistance = 10000
//            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//            let options = [
//                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//            ]
//            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//            let mapItem = MKMapItem(placemark: placemark)
//            mapItem.name = ""
//            mapItem.openInMaps(launchOptions: options)
//        }
//    }
//
//    class func getSafariPage(url: String) -> UIViewController? {
//        if let url = URL(string: url) {
//            let config = SFSafariViewController.Configuration()
//            config.entersReaderIfAvailable = true
//            let vc = SFSafariViewController(url: url, configuration: config)
//            return vc
//        }
//        return nil
//    }

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
