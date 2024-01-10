//
//  BaseVC.swift
//  Damin
//
//  Created by Amr Ali on 17/08/2023.
//

class Language {
    public static let english = "en"
    public static let arabic = "ar"
}


import UIKit
//import SideMenu

class BaseVC: UIViewController {

    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
   // var menu : SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        
        
        if "lang".localized() != Language.english {
            AppLanguage.shared.set(index: .arabic)
        }else{
            AppLanguage.shared.set(index: .english)
        }
        
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        
        if let navController = self.navigationController  {
          //  navigator = Navigator(navController: navController)
        }
    }

    func showLoader() {
        indicator.startAnimating()
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
//    func sideMenuPressed(){
//
//        let sideVc =  SideMenuTableViewController()
//        menu = SideMenuNavigationController(rootViewController: sideVc)
//        menu?.setNavigationBarHidden(true, animated: false)
//        let storyboard = UIStoryboard(name: "SideMenuStoryboard", bundle: nil)
//        menu = storyboard.instantiateViewController(withIdentifier: "RightMenu") as? SideMenuNavigationController
//
//
//        if UserDefaultsManager.instance.getCurrentLanguage() != nil {
//            if UserDefaultsManager.instance.getCurrentLanguage() == "ar" {
//                menu?.leftSide = false
//            }else {
//                menu?.leftSide = true
//            }
//        }else {
//            if "lang".localized() != "en" {
//                menu?.leftSide = true
//            }else{
//                menu?.leftSide = false
//            }
//        }
//
//        present(menu!, animated: true)
//
//        menu?.presentationStyle.onTopShadowOpacity = 0.5
//    }
    
}
