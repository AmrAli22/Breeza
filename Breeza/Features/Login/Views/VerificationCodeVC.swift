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

             // Add target to each UITextField to handle editing change
             verfCodeOne.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
             verfCodeTwo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
             verfCodeThree.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
             verfCodeFour.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
         }

         // UITextFieldDelegate method to limit to one character and move to the next UITextField
         func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
             let currentText = textField.text ?? ""
             let newLength = currentText.count + string.count - range.length

             if newLength <= 1 {
                 if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                     textField.text = string
                     nextTextField.becomeFirstResponder()
                 }
                 return false
             } else {
                 return false
             }
         }

         // Handle editing change to move the cursor when the length is one
         @objc func textFieldDidChange(_ textField: UITextField) {
             if let text = textField.text, text.count == 1 {
                 if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                     nextTextField.becomeFirstResponder()
                 }
             }
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
