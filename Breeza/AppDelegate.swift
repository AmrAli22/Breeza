//
//  AppDelegate.swift
//  Damin
//
//  Created by Amr Ali on 25/07/2023.
//

import UIKit
import IQKeyboardManagerSwift
import Localize_Swift
import JVFloatLabeledTextField
import sd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    public static var instance   : AppDelegate?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        IQKeyboardManager.shared.enable = true
        startApplication()

        return true
    }


    func startApplication() {
        AppDelegate.instance = self
        if #available(iOS 13.0, *) {
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
        refreshAppLanguage()
        setSemantics()
    
//        if let token = UserDefaultsManager.instance.getRegisterModel()?.result?.token {
//    
//        }else{
//            goToOnboarding()
//        }
        goToSplash()
  
    }
    
    func refreshAppLanguage() {
        Localize.setCurrentLanguage("ar")
        UserDefaultsManager.instance.saveCurrentLanguage(language: "ar")
    }
    
    
    func goToSplash() {
        let navigationController = UINavigationController(rootViewController: OnboradingLogoVC.buildVC())
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

    
    func goToOnboarding() {
        let navigationController = UINavigationController(rootViewController: OnboradingImagesVC.buildVC())
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    

    
    public func setSemantics() {
        switch Localize.currentLanguage() {
        case "ar":
            setSemanticContentAttributeAndContentHorizontalAlignment(semanticContentAttribute: .forceRightToLeft, contentHorizontalAlignment: .right)
            break

        case "en":
            setSemanticContentAttributeAndContentHorizontalAlignment(semanticContentAttribute: .forceLeftToRight, contentHorizontalAlignment: .left)
            break

        default:
            break
        }
    }
    
    public func setSemanticContentAttributeAndContentHorizontalAlignment(semanticContentAttribute: UISemanticContentAttribute,contentHorizontalAlignment: UIControl.ContentHorizontalAlignment) {
        
        UIView.appearance().semanticContentAttribute = semanticContentAttribute
        UILabel.appearance().semanticContentAttribute = semanticContentAttribute
        UITextField.appearance().semanticContentAttribute = semanticContentAttribute
        UIButton.appearance().semanticContentAttribute = semanticContentAttribute
        UIImageView.appearance().semanticContentAttribute = semanticContentAttribute
        UITableView.appearance().semanticContentAttribute = semanticContentAttribute
        UICollectionView.appearance().semanticContentAttribute = semanticContentAttribute
        UINavigationBar.appearance().semanticContentAttribute = semanticContentAttribute
        UITabBar.appearance().semanticContentAttribute = semanticContentAttribute
        JVFloatLabeledTextField.appearance().semanticContentAttribute = semanticContentAttribute
        if semanticContentAttribute == .forceRightToLeft {
            JVFloatLabeledTextField.appearance().textAlignment = .right
        }else{
            JVFloatLabeledTextField.appearance().textAlignment = .left
        }
        UITableViewCell.appearance().semanticContentAttribute = semanticContentAttribute
        UICollectionViewCell.appearance().semanticContentAttribute = semanticContentAttribute
        UISearchBar.appearance().semanticContentAttribute = semanticContentAttribute
        UIProgressView.appearance().semanticContentAttribute = semanticContentAttribute
        UITextField.appearance().semanticContentAttribute = semanticContentAttribute
    }
    
    
}

