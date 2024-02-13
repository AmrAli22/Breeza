//
//  HomeTabber.swift
//  Breeza
//
//  Created by Amr Ali on 30/01/2024.
//

import UIKit

class HomeTabber: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    public class func buildVC() -> HomeTabber {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeTabber") as! HomeTabber
        return view
    }

}
