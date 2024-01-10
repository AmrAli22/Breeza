//
//  AppLanguague.swift
//  QDPM-Muzaf
//
//  Created by Amr Ali on 28/02/2023.
//

import UIKit

enum Languages {
    case english, arabic, french
}

class AppLanguage {
    
    static let shared = AppLanguage()
    private init() { }
    
    var bundle: Bundle?
    
    func set(index: Languages) {
        switch index {
        case .english:
            // For English Language set LTR
            print("Set language to LTR")
            selectBundleForResource(forResource: "en", isRTL: false)
        case .arabic:
            // For RTL Language set RTL
            print("Set language to RTL.")
            selectBundleForResource(forResource: "ar", isRTL: true)
        default:
            // For French Language set LTR
            selectBundleForResource(forResource: "fr", isRTL: false)
        }
        
    }
    
    private func selectBundleForResource(forResource: String!, isRTL: Bool) {
        guard let path = Bundle.main.path(forResource: forResource, ofType: "lproj") else {
            return
        }
        self.bundle = Bundle.init(path: path)
        switchViewControllers(isRTL: isRTL)
    }
    
    private func setKeyWindowFromAppDelegate(isRTL: Bool) {
        UIView.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as? AppDelegate
        let homeViewController = UIViewController() // Replace with your root view controller.
        appDelegate?.window?.rootViewController = homeViewController
    }
    
    private func switchViewControllers(isRTL rtl : Bool){
        if rtl {
            setKeyWindowFromAppDelegate(isRTL: true)
        } else {
            setKeyWindowFromAppDelegate(isRTL: false)
        }
    }
}

public extension String {
    /// Return Localized String
    var localizedString : String {
        get {
            return self.toLocal()
        }
    }
}

private extension String {
    func toLocal() -> String {
        if AppLanguage.shared.bundle != nil {
            return NSLocalizedString(self, tableName: "Localizable", bundle: AppLanguage.shared.bundle!, value: "", comment: "")
        }
        return self
    }
}
