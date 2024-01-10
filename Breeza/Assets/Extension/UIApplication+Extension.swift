//
//  UIApplication+Extension.swift
//  fardyah-ios
//
//  Created by Esraa Apady on 6/18/18.
//  Copyright © 2018 Canary. All rights reserved.
//

import UIKit
import Localize_Swift

extension UIApplication {

    
    var statusBarView: UIView? {
//        if responds(to: Selector("statusBar")) {
//            return value(forKey: "statusBar") as? UIView
//        }
        return nil
    }

    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }

    class func isRTL() -> Bool{
        return Localize.currentLanguage() != "en" || Localize.currentLanguage() == "ar"
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
    var versionAndBuildNumber: String {
        return "\(self.releaseVersionNumber ?? "0")" + "." + "\(self.buildVersionNumber ?? "0")"
    }
}
