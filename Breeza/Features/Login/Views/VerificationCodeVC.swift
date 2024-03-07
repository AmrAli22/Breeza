//
//  VerificationCodeVC.swift
//  Breeza
//
//  Created by Amr Ali on 27/02/2024.
//


import UIKit

class VerificationCodeVC: BaseVC , UITextFieldDelegate{
    

    @IBOutlet weak var verfCodeOne: UITextField!
    @IBOutlet weak var verfCodeTwo: UITextField!
    @IBOutlet weak var verfCodeThree: UITextField!
    @IBOutlet weak var verfCodeFour: UITextField!
    
    @IBOutlet weak var resendBtn: UIButton!
    
    var presenter  : AuthPresenter!
    
    public class func buildVC(pres : AuthPresenter) -> VerificationCodeVC {
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
        pres.authView = view
        view.presenter = pres
        return view
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.authView = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verfCodeOne.delegate = self
        verfCodeTwo.delegate = self
        verfCodeThree.delegate = self
        verfCodeFour.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the new string has only one character
        return string.count <= 1
    }
    
    @IBAction func resetPassPressed(_ sender: Any) {
        
        if (verfCodeOne.text    != "") &&
            (verfCodeTwo.text   != "") &&
            (verfCodeThree.text != "") &&
            (verfCodeFour.text  != "") {
            var resetCode  = verfCodeOne.text   ?? ""
                resetCode += verfCodeTwo.text   ?? ""
                resetCode += verfCodeThree.text ?? ""
                resetCode += verfCodeFour.text  ?? ""
            
            self.presenter.confrimCode(resetCode: resetCode)
        }
    }
}

extension VerificationCodeVC : AuthView {
    func successForgotPass() {
        self.navigationController?.pushViewController(VerificationCodeVC.buildVC(pres: self.presenter), animated: true)
    }
    
    func successVerfCode() {
        self.navigationController?.pushViewController(CreateNewPassVC.buildVC(pres: self.presenter), animated: true)
    }
    
    func successChangePass() {
        
    }
    
    func showSpinner() {
        showLoader()
    }
    
    func hideSpinner() {
        hideLoader()
    }
    
    func SuccessLogin() {
    }
    
    func FailureAlert(with error: String) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error".localized(), withMessage: error)
        }
    }
    
    func SuccessAlert(with msg: String) {
        
        DispatchQueue.main.async {
            self.showAlert(title: "Success".localized(), withMessage: "")
        }
    }
}
