//
//  LoginVC.swift
//  Breeza
//
//  Created by Amr Ali on 17/01/2024.
//

import UIKit
import JVFloatLabeledTextField
import IQKeyboardManagerSwift

class LoginVC: BaseVC{
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var lockPassBtn: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var AlertLabel: UIButton!
    @IBOutlet weak var loginBtnConstraint: NSLayoutConstraint!
    
    var presenter  : AuthPresenter!
    
    var originalloginStackViewY = 0.0
    var originalCreateAccountY  = 0.0
    var isKeyboardActive        = false
    var keyboardFrameHeight     = 0.0

    
    public class func buildVC() -> LoginVC {
        let    storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let    view = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let    pres = AuthPresenter(authView: view)
               view.presenter = pres
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButtonS()
        self.AlertLabel.isHidden = true
    

           NotificationCenter.default.addObserver(
             self,
             selector: #selector(keyboardWillShow),
             name: UIResponder.keyboardWillShowNotification,
             object: nil)
             
            NotificationCenter.default.addObserver(
                 self,
                 selector: #selector(keyboardWillHide),
                 name: UIResponder.keyboardWillHideNotification,
                 object: nil)

    }
    
    @IBAction func lockPassBtnPressed(_ sender: Any) {
        passwordTxtField.isSecureTextEntry.toggle()
    }
    
    @IBAction func ForgotPassBtnPressed(_ sender: Any) {
        self.navigationController?.pushViewController(ForgotPassVC.buildVC(pres: self.presenter), animated: true)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let username = emailTxtField.text ?? ""
        let pass     = passwordTxtField.text ?? ""
        self.presenter.Login(user_name: username, password_: pass)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            
//            loginBtnConstraint?.constant = (keyboardHeight - 60)
//            UIView.animate(withDuration: 0.25) {
//                self.view.layoutIfNeeded()
//            }
//        }
    }
   
    @objc func keyboardWillHide(_ notification: Notification) {
//        loginBtnConstraint?.constant = 0
//            UIView.animate(withDuration: 0.25) {
//                self.view.layoutIfNeeded()
//            }
     }

    
//    override func setupBackButtonS() {
//        let color = UIColor(hex: "#3D5AA8")
//
//        self.navigationController?.navigationBar.topItem?.title = " "
//        self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = color
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = color
//        self.navigationController?.navigationBar.tintColor = color;
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = true
        self.presenter.authView = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
    }
    
    func setupBackButton() {
        let color = UIColor(hex: "#3D5AA8")

        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = color
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = color
        self.navigationController?.navigationBar.tintColor = color;
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginVC : AuthView {
    func successForgotPass() {
        
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
        hideLoader()
        AppDelegate.instance?.goToHome()
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
