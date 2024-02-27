//
//  userDefaultConstants.swift
//  Breeza
//
//  Created by Amr Ali on 11/01/2024.
//

import UIKit

class UserDefaultsConstants {
    public static let language           = "Language"
    public static let serverToken        = "ServerToken"
    public static let userID             = "user_ID"
    public static let isUserManager      = "is_User_Manager"
    public static let Noti               = "Noti"
    public static let userData           = "userProfileData"
    public static let refreshToken       = "refreshToken"
}


public struct APIUrlsConstants {
    //MARK: - BASE API_MAIN_URL
    public static let APIMainURL     = "http://123-env.eba-r2jth8tp.us-east-1.elasticbeanstalk.com"
    public static let login          = "/api/v1/authentication/sign-in"
    public static let homeProducts   = "/api/v1/product/filtered"
    public static let refreshToken   = "/api/v1/authentication/refresh-token"
    public static let forgotPass     = "/api/v1/authentication/forgot-password"
    public static let confirmCode    = "/api/v1/authentication/confirm-code"
    public static let changePass     = "/api/v1/authentication/change-password"

    public static let categories     = "/api/v1/categories"
    public static let supplier       = "/api/v1/supplier"
    public static let brands         = "/api/v1/brands"
    
  
    
}
