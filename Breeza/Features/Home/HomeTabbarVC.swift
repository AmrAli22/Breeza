//
//  HomeTabbarVC.swift
//  Breeza
//
//  Created by Amr Ali on 30/01/2024.
//

import UIKit

class HomeTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    public class func buildVC() -> HomeTabbarVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeTabbarVC") as! HomeTabbarVC
        return view
    }
    
}
