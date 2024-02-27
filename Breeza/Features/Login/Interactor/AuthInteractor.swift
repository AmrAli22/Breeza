//
//  AuthInteractor.swift
//  Breeza
//
//  Created by Amr Ali on 27/02/2024.
//

import Foundation
import Alamofire

struct AuthInteractor {
    //MARK: - login
    
    typealias loginComplation = ( _ error: ErrorResponse?) -> ()
    func login(username          : String ,
               password          : String ,
               completion: @escaping loginComplation) {
        
        let params =  ["username"             :"\(username)",
                       "password"             :"\(password)"   ] as [String: Any]
   
        NetworkingManager.sendReq(method: .post , url: APIUrlsConstants.login , params: params , encoding: JSONEncoding.default ) { data in
            do {
                let dataResponse: TokenModel = try JSONDecoder().decode(TokenModel.self, from: data!)
                
                if let token = dataResponse.token {
                    if let refreshToken = dataResponse.refreshToken {
                        
                        UserDefaultsManager.instance.saveCurrentToken(Token: token)
                        UserDefaultsManager.instance.saveRefreshToken(refreshToken: refreshToken)
                        completion(nil)
                    }
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
    
    //MARK: - forgotPass
    typealias forgotPassComplation = ( _ error: ErrorResponse?) -> ()
    
    func forgotPass(email               : String ,
                    completion: @escaping forgotPassComplation) {
        
        let params =  ["email"             :"\(email)"  ] as [String: Any]
   
        NetworkingManager.sendReq(method: .post , url: APIUrlsConstants.forgotPass , params: nil ,Appendedparams: params ,  encoding: JSONEncoding.default ) { response in
            completion(nil)
            return
        } errorHandler: { error in
            completion(error)
            return
        }
    }
    
    
    
    typealias confrimCodeComplation = ( _ error: ErrorResponse?) -> ()
    
    func confrimCode(email               : String ,
                    resetCode           : String ,
                    completion: @escaping loginComplation) {
        
        let params =  ["email"                 :"\(email)"  ,
                       "resetCode"             :"\(resetCode)"  ] as [String: Any]
   
        NetworkingManager.sendReq(method: .post , url: APIUrlsConstants.confirmCode , params: nil ,Appendedparams: params ,  encoding: JSONEncoding.default ) { response in
            completion(nil)
            return
        } errorHandler: { error in
            completion(error)
            return
        }
    }
    
    
    typealias changePassComplation = ( _ error: ErrorResponse?) -> ()
    
    func changePass(email                 : String ,
                     resetCode             : String ,
                     newPassword           : String ,
                    completion: @escaping changePassComplation) {
        
        let params =  ["email"                 :"\(email)"     ,
                       "resetCode"             :"\(resetCode)" ,
                       "newPassword"           :"\(newPassword)"   ] as [String: Any]
   
        NetworkingManager.sendReq(method: .post , url: APIUrlsConstants.changePass , params: nil ,Appendedparams: params ,  encoding: JSONEncoding.default ) { response in
            completion(nil)
            return
        } errorHandler: { error in
            completion(error)
            return
        }
    }

    
}
