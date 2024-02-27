//
//  NetwrokManger.swift
//  Breeza
//
//  Created by Amr Ali on 17/01/2024.
//


import Alamofire
import UIKit

class NetworkingManager {
    
    static var refreshTokenAttempts = 0
    static let maxRefreshTokenAttempts = 3
    
    static func sendRequestAuth(method: HTTPMethod, url: String, headers: HTTPHeaders? = nil,
                                params: [String: Any]? , Appendedparams: Any? = nil , encoding: ParameterEncoding = URLEncoding.default,
                                successHandler: @escaping (_ response: Data?)->(),
                                errorHandler: @escaping (_ error:ErrorResponse?)->()) {
        
        var recievedHeaders = headers
        if recievedHeaders == nil {
            recievedHeaders = HTTPHeaders()
        }
        
        guard let token = UserDefaultsManager.instance.getCurrentToken() else { return  }
        
        recievedHeaders?.add(name: "Content-Type", value: "application/json")
        recievedHeaders?.add(name: "Authorization", value: "Bearer " + token)
        recievedHeaders?.add(name: "Accept", value: "*/*")
        recievedHeaders?.add(name: "Cookie", value: "DCSToken=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6OSwibmFtZSI6InRoZWFtcmFsaSIsInN1YiI6IjkiLCJpYXQiOjE3MDU1MTkwODEsImV4cCI6MTcwNTUyNjI4MX0.Pa4FA8IEHU1ThEGpJl5DN20xC1YayFGiNH8Pys2lAXbk68ZOmguHbbsUzmvENNodayz2cL9gGe157uoRg308pw")
        
        var ComputedUrl = APIUrlsConstants.APIMainURL + url
        
        if let Appendedparams = Appendedparams {
            ComputedUrl = buildURL(baseURL: ComputedUrl , parameters: Appendedparams as! [String : Any]) ?? ComputedUrl
        }
  
        let AddedParms = params
        
        AF.request(ComputedUrl , method: method,parameters: AddedParms ?? [:], encoding: encoding, headers: recievedHeaders)
            .responseJSON(completionHandler: {  response in
                
                print("URL:\(response.request?.url)")
                print("Headers:\(response.request?.headers)")
                print("Params:\(AddedParms)")
                print("response:\(response)")
                
                if (response.response?.statusCode == 200 ) || (response.response?.statusCode == 201 ) {
                    successHandler(response.data)
                    return
                }
                
                if response.response?.statusCode == 401 {
                    if refreshTokenAttempts < maxRefreshTokenAttempts {
                        refreshTokenAttempts += 1
                        newrefresh { success in
                            if success == true{
                                // Retry the original request after token refresh
                                self.sendRequestAuth(method: method, url: url, headers: headers, params: params, Appendedparams: Appendedparams, encoding: encoding, successHandler: successHandler, errorHandler: errorHandler)
                            } else {
                                // Token refresh failed, handle accordingly
                                print("Token refresh failed.")
                                errorHandler(nil) // or pass an appropriate error
                            }
                        }
                    } else {
                        // Max attempts reached, handle accordingly
                        print("Max refresh token attempts reached.")
                        errorHandler(nil) // or pass an appropriate error
                    }
//                    
                    
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
    
    static func buildURL(baseURL: String, parameters: [String: Any]) -> String? {
        var urlComponents = URLComponents(string: baseURL )

        // Add parameters to URL
        urlComponents?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }

        
        return urlComponents?.url?.absoluteString ?? ""
    }
    
    typealias refreshTokenComplation = (_ done: Bool?) -> ()
   static func newrefresh(completion: @escaping refreshTokenComplation) {
       let refreshToken =  UserDefaultsManager.instance.getRefreshToken() ?? ""
       let parameters = "{\n  \"refreshToken\": \"\(refreshToken)\"\n}"
       let postData = parameters.data(using: .utf8)

       var request = URLRequest(url: URL(string: "http://123-env.eba-r2jth8tp.us-east-1.elasticbeanstalk.com/api/v1/authentication/refresh-token")!,timeoutInterval: Double.infinity)
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       request.addValue("*/*", forHTTPHeaderField: "Accept")

       request.httpMethod = "POST"
       request.httpBody = postData

       let task = URLSession.shared.dataTask(with: request) { data, response, error in
         guard let data = data else {
             completion(false)
             return
         }
           
           do {
               
               let dataResponse: TokenModel = try JSONDecoder().decode(TokenModel.self, from: data)
               
               if let token = dataResponse.token {
                   if let refreshToken = dataResponse.refreshToken {
                       UserDefaultsManager.instance.saveCurrentToken(Token: token)
                       UserDefaultsManager.instance.saveRefreshToken(refreshToken: refreshToken)
                       
                       completion(true)
                       return
                   }
               }
               completion(false)
               return
           } catch (let error) {
               let errorResponse = ErrorResponse(message: error.localizedDescription)
               completion(false)
               return
           }
       }
       
       task.resume()

    }
    
    ///typealias refreshTokenComplation = (_ done: Bool?) -> ()
    static func refreshToken(completion: @escaping refreshTokenComplation){
        
        let params: [String: Any] = [
            "refreshToken": UserDefaultsManager.instance.getRefreshToken() ?? ""
        ]
        
        NetworkingManager.sendReq(method: .post, url: APIUrlsConstants.refreshToken , params: params , encoding: JSONEncoding.default) { data in
            do {
                
                let dataResponse: TokenModel = try JSONDecoder().decode(TokenModel.self, from: data!)
                
                if let token = dataResponse.token {
                    if let refreshToken = dataResponse.refreshToken {
                        UserDefaultsManager.instance.saveCurrentToken(Token: token)
                        UserDefaultsManager.instance.saveRefreshToken(refreshToken: refreshToken)
                        
                        completion(true)
                        return
                    }
                }
                completion(false)
                return
            } catch (let error) {
                let errorResponse = ErrorResponse(message: error.localizedDescription)
                completion(false)
                return
            }
        } errorHandler: { error in
            completion(false)
            return
        }
    }
    
    
    static func sendReq(method: HTTPMethod, url: String, headers: HTTPHeaders? = nil,
                        params: [String: Any]? , Appendedparams: Any? = nil , encoding: ParameterEncoding = URLEncoding.default,
                        successHandler: @escaping (_ response: Data?)->(),
                        errorHandler: @escaping (_ error:ErrorResponse?)->()) {
        
        let Basicheaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "accept": "*/*",
//            "Cookie": "DCSToken=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6OSwibmFtZSI6InRoZWFtcmFsaSIsInN1YiI6IjkiLCJpYXQiOjE3MDU1MTkwODEsImV4cCI6MTcwNTUyNjI4MX0.Pa4FA8IEHU1ThEGpJl5DN20xC1YayFGiNH8Pys2lAXbk68ZOmguHbbsUzmvENNodayz2cL9gGe157uoRg308pw"
        ]
        
        var ComputedUrl = APIUrlsConstants.APIMainURL + url
        
        if let Appendedparams = Appendedparams {
            ComputedUrl = buildURL(baseURL: ComputedUrl , parameters: Appendedparams as! [String : Any]) ?? ComputedUrl
        }
        
        AF.request(ComputedUrl , method: method,parameters: params ?? [:], encoding: encoding, headers: Basicheaders)
            .responseJSON(completionHandler: {  response in
                
                
                if (response.response?.statusCode == 200 ) || (response.response?.statusCode == 201 ) {
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
                
                
//                switch response.response?.statusCode == 200 {
//            case .success(let data):
//
//                    if response.response?.statusCode == 200 {
//                        successHandler(response.data)
//                        return
//                    } else {
//                        
//                        if ((response.value as? [String : Any]) != nil){
//                            
//                            let error = ErrorResponse(error: response.value as! [String : Any])
//                            errorHandler(error)
//                            return
//                        }else{
//                            let error = ErrorResponse(message: "please_check_your_internet_connection_and_try_again".localized())
//                            errorHandler(error)
//                            return
//                        }
//                    }
//            case .failure(let error):
//                let error = ErrorResponse(message: error.localizedDescription)
//                errorHandler(error)
//                return
//            }
        }
    )}
}


