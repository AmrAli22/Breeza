//
//  ForgotPassVC.swift
//  Breeza
//
//  Created by Amr Ali on 27/02/2024.
//


import UIKit

class ForgotPassVC: BaseVC {
    
    @IBOutlet weak var emailTxtFeild: UITextField!
    
    var presenter  : AuthPresenter!
    
    public class func buildVC(pres :AuthPresenter ) -> ForgotPassVC {
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        pres.authView = view
        view.presenter = pres
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.authView = self
    }
    
    
    @IBAction func resetPassBtnPressed(_ sender: Any) {
        let emailo = emailTxtFeild.text ?? ""
        if isValidEmail(emailo) {
            self.presenter.forgotPass(email: emailo)
        }else{
            self.FailureAlert(with: "Email not valid")
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        // Regular expression for a basic email pattern
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
}

extension ForgotPassVC : AuthView {
    func successForgotPass() {
        self.navigationController?.pushViewController(VerificationCodeVC.buildVC(pres: self.presenter), animated: true)
    }
    
    func successVerfCode() {
        
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
