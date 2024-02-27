//
//  AuthPresenter.swift
//  Breeza
//
//  Created by Amr Ali on 17/01/2024.
//

import Foundation


protocol AuthView: AnyObject {
    func showSpinner()
    func hideSpinner()
    func SuccessLogin()
    func FailureAlert(with error: String)
    func SuccessAlert(with msg  : String)
    
    func successForgotPass()
    func successVerfCode()
    func successChangePass()

}

//MARK: - AuthPresenter
class AuthPresenter {
    
    //MARK: - PresenterView
    weak var authView: AuthView?
    //MARK: - PresenterInteractor
    let authInteractor = AuthInteractor()
    
    var username          = ""
    var password          = ""
    
    var email             = ""
    var ResetCode         = ""
    
    //MARK: - PresenterConstractours
    init(authView: AuthView ) {
        self.authView = authView
    }
    
    //MARK: - sendOtpForLogin
    func Login(user_name : String , password_ : String){
        self.authView?.showSpinner()
        
        authInteractor.login(username: user_name, password: password_) {
            [weak self ] (error) in
            guard let self = self else { return }
            self.authView?.hideSpinner()
            
            if let _ = error {
                self.authView?.FailureAlert(with: "Password or username is wrong")
            }else{
                self.authView?.SuccessLogin()
                return
            }
        }
    }
    
    //MARK: - forgotPass
    func forgotPass(email : String ){
        self.authView?.showSpinner()
        authInteractor.forgotPass(email: email) {   [weak self ] (error) in
        
            guard let self = self else { return }
            self.authView?.hideSpinner()
            
            if let _ = error {
                self.authView?.FailureAlert(with: "Email is wrong")
            }else{
                self.email = email
                self.authView?.successForgotPass()
                return
            }
        }
    }
    
    func confrimCode(resetCode : String ){
        self.authView?.showSpinner()
        authInteractor.confrimCode(email: self.email, resetCode: resetCode) {   [weak self ] (error) in
        
            guard let self = self else { return }
            self.authView?.hideSpinner()
            
            if let _ = error {
                self.authView?.FailureAlert(with: "Reset Code is wrong")
            }else{
                self.ResetCode = resetCode
                self.authView?.successVerfCode()
                return
            }
        }
    }
    
    
    func changePass(newPass : String ){
        self.authView?.showSpinner()
        authInteractor.changePass(email: self.email, resetCode: self.ResetCode, newPassword: newPass) { [weak self ] (error) in
        
            guard let self = self else { return }
            self.authView?.hideSpinner()
            
            if let _ = error {
                self.authView?.FailureAlert(with: "Change Password Failed")
            }else{
                self.authView?.successChangePass()
                return
            }
        }
    }
    
}


