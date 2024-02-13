//
//  AuthPresenter.swift
//  Breeza
//
//  Created by Amr Ali on 17/01/2024.
//

import Foundation
import Alamofire

protocol AuthView: AnyObject {
    func showSpinner()
    func hideSpinner()
    func SuccessLogin()
    func FailureAlert(with error: String)
    func SuccessAlert(with msg  : String)

}

//MARK: - AuthPresenter
class AuthPresenter {
    
    //MARK: - PresenterView
    weak var authView: AuthView?
    //MARK: - PresenterInteractor
    let authInteractor = AuthInteractor()
    
    var username          = ""
    var password          = ""
    
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
}

struct AuthInteractor {
    //MARK: - login
    
    typealias loginComplation = ( _ error: ErrorResponse?) -> ()
    
    func login(username          : String ,
               password          : String ,
               completion: @escaping loginComplation) {
        
        let params =  ["username"             :"\(username)",
                       "password"             :"\(password)"   ] as [String: Any]
   
        NetworkingManager.sendReq(method: .post , url: APIUrlsConstants.login , params: params ) { data in
            do {
                let dataResponse: TokenModel = try JSONDecoder().decode(TokenModel.self, from: data!)
                
                if let token = dataResponse.token {
                    UserDefaultsManager.instance.saveCurrentToken(Token: token)
                    completion(nil)
                    
                    return
                }else{
                        let error = ErrorResponse(message: "Password or username is wrong")
                        completion(error)
                        return
                }
            } catch (let error) {
                let errorResponse = ErrorResponse(message: error.localizedDescription)
                completion(errorResponse)
                return
            }
        } errorHandler: { error in
            completion(error)
            return
        }
    }
}

struct TokenModel: Codable {
    var token: String?
}
