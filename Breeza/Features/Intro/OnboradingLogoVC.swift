//
//  OnboradingLogoVC.swift
//  Breeza
//
//  Created by Amr Ali on 11/01/2024.
//


import UIKit

class OnboradingLogoVC: BaseVC {
    
    @IBOutlet weak var logoImage: UIImageView!

    public class func buildVC() -> OnboradingLogoVC {
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "OnboradingLogoVC") as! OnboradingLogoVC
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = .white
        self.logoImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.logoImage.alpha = 0.0
        UIView.animate(withDuration: 4.00, animations: { [weak self] in
            self?.logoImage.alpha = 1.0
            self?.logoImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { [weak self] (finished: Bool) in
            if(finished){
                AppDelegate.instance?.goToOnboarding()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
