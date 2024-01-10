//
//  StartVC.swift
//  Breeza
//
//  Created by Amr Ali on 11/01/2024.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        
        loginBtn.clipsToBounds      = true
        loginBtn.layer.cornerRadius = 32
        
    }
    
    public class func buildVC() -> StartVC {
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "StartVC") as! StartVC
        return view
    }
    
    
    @IBAction func LoginPressed(_ sender: Any) {
        DispatchQueue.main.async {
         //   self.navigationController?.pushViewController(CreateAccVC.buildVC(), animated: true)
        }
    }
}
