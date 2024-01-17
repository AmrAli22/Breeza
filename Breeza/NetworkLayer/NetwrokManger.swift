//
//  NetwrokManger.swift
//  Breeza
//
//  Created by Amr Ali on 17/01/2024.
//


import Alamofire
import UIKit

class NetworkingManager {
    
    static func sendRequestAuth(method: HTTPMethod, url: String, headers: HTTPHeaders? = nil,
                                params: [String: Any]? , Appendedparams: Any? = nil , encoding: ParameterEncoding = URLEncoding.default,
                                successHandler: @escaping (_ response: Data?)->(),
                                errorHandler: @escaping (_ error:ErrorResponse?)->()) {
        
        var recievedHeaders = headers
        if recievedHeaders == nil {
            recievedHeaders = HTTPHeaders()
        }
        
        guard let token = UserDefaultsManager.instance.getCurrentToken() else { return  }
        
        let WantedLang = UserDefaultsManager.instance.getCurrentLanguage()?.contains("ar") ?? true ? "ar" : "en"
        
        recievedHeaders?.add(name: "accept", value: "text/plain")
        recievedHeaders?.add(name: "Authorization", value: "Bearer " + token)
        recievedHeaders?.add(name: "Accept-Language", value: "\(WantedLang)")
        recievedHeaders?.add(name: "Content-Type", value: "application/json")
        
        var ComputedUrl = APIUrlsConstants.APIMainURL + url
        
        if let Appendedparams = Appendedparams {
            ComputedUrl += "/"
            ComputedUrl += "\(Appendedparams)"
        }
        
        var AddedParms = params
        
        
        
        
        AF.request(ComputedUrl , method: method,parameters: AddedParms ?? [:], encoding: encoding, headers: recievedHeaders)
            .responseJSON(completionHandler: {  response in
                
                print("URL:\(response.request?.url)")
                print("Headers:\(response.request?.headers)")
                print("Params:\(AddedParms)")
                print("response:\(response)")
                
                
                
                if response.response?.statusCode == 200 {
                    successHandler(response.data)
                    return
                } else {
                    
                    if ((response.value as? [String : Any]) != nil){
                        
                        let error = ErrorResponse(error: response.value as! [String : Any])
                        errorHandler(error)
                        return
                    }else{
                        let error = ErrorResponse(message: "please_check_your_internet_connection_and_try_again".localized())
                        errorHandler(error)
                        return
                    }
                }
            })
    }
    
    static func sendReq(method: HTTPMethod, url: String, headers: HTTPHeaders? = nil,
                        params: [String: Any]? , Appendedparams: Any? = nil , encoding: ParameterEncoding = URLEncoding.default,
                        successHandler: @escaping (_ response: Data?)->(),
                        errorHandler: @escaping (_ error:ErrorResponse?)->()) {
        
        let Basicheaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Cookie": "DCSToken=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6OSwibmFtZSI6InRoZWFtcmFsaSIsInN1YiI6IjkiLCJpYXQiOjE3MDU1MTkwODEsImV4cCI6MTcwNTUyNjI4MX0.Pa4FA8IEHU1ThEGpJl5DN20xC1YayFGiNH8Pys2lAXbk68ZOmguHbbsUzmvENNodayz2cL9gGe157uoRg308pw"
        ]
        
        var ComputedUrl = APIUrlsConstants.APIMainURL + url
        
        AF.request(ComputedUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Basicheaders).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                    
                    if response.response?.statusCode == 200 {
                        successHandler(response.data)
                        return
                    } else {
                        
                        if ((response.value as? [String : Any]) != nil){
                            
                            let error = ErrorResponse(error: response.value as! [String : Any])
                            errorHandler(error)
                            return
                        }else{
                            let error = ErrorResponse(message: "please_check_your_internet_connection_and_try_again".localized())
                            errorHandler(error)
                            return
                        }
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
        

