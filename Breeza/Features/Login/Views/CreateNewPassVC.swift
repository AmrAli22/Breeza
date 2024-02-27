//
//  CreateNewPassVC.swift
//  Breeza
//
//  Created by Amr Ali on 27/02/2024.
//

import UIKit

class CreateNewPassVC: BaseVC {
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confrimPasswordTxtField: UITextField!
    @IBOutlet weak var passNotMatchedAlert: UIButton!
    
    var presenter  : AuthPresenter!

    public class func buildVC(pres : AuthPresenter) -> CreateNewPassVC {
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CreateNewPassVC") as! CreateNewPassVC
        pres.authView = view
        view.presenter = pres
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func resendBtnPressed(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func createPressed(_ sender: Any) {
        let password     = self.passwordTxtField.text ?? ""
        let confpassword = self.confrimPasswordTxtField.text ?? ""
        
        
        if (password == confpassword) && (password.count > 7)  {
            self.presenter.changePass(newPass: password)
        }else{
            FailureAlert(with: "please make sure that password and confirm password are matched and contains 8 characters or more")
        }
        
    }
}

extension CreateNewPassVC : AuthView {
    func successForgotPass() {
        self.navigationController?.pushViewController(VerificationCodeVC.buildVC(pres: self.presenter), animated: true)
    }
    
    func successVerfCode() {
        
    }
    
    func successChangePass() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let popupVC = storyboard.instantiateViewController(withIdentifier: "ItemAddedPopUp") as? ItemAddedPopUp {
            popupVC.popUpTitle.text = "Success"
            popupVC.popUpDesc.text  = "You have successfully reset your password."
            popupVC.BtnConfrimText.setTitle("Login", for: .normal)
            
            popupVC.didPressInfoBtnAction = { [weak self] in
                guard let self = self else { return }
                self.navigationController?.pushViewController(LoginVC.buildVC(), animated: true)
            }
            present(popupVC, animated: true, completion: nil)
        }
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
