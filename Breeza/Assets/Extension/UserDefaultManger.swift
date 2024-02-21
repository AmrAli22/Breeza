//
//  UserDefaultManger.swift
//  Damin
//
//  Created by Amr Ali on 29/07/2023.
//

import Foundation




class UserDefaultsManager {
    
    private let defaults = UserDefaults.standard
    
    static var instance = UserDefaultsManager()
    
    
    func saveCurrentLanguage(language: String) {
        defaults.setValue(language, forKey: UserDefaultsConstants.language)
    }
    
    func getCurrentLanguage() -> String? {
        return defaults.string(forKey: UserDefaultsConstants.language)
    }
    
    func saveCurrentToken(Token: String) {
        defaults.setValue(Token, forKey: UserDefaultsConstants.serverToken)
    }
    
    func getCurrentToken() -> String? {
        return defaults.string(forKey: UserDefaultsConstants.serverToken)
    }
    
    func saveUserID(ID: Int) {
        defaults.setValue(ID, forKey: UserDefaultsConstants.userID)
    }
    
    func getUserID() -> String? {
        return defaults.string(forKey: UserDefaultsConstants.userID)
    }
    
    func saveUser(IsManager: Bool) {
        defaults.setValue(IsManager, forKey: UserDefaultsConstants.isUserManager)
    }
    
    func getUserIsManager() -> String? {
        return defaults.string(forKey: UserDefaultsConstants.isUserManager)
    }
    
    
    func RemoveCurrentToken() {
        return defaults.removeObject(forKey: UserDefaultsConstants.serverToken)
    }
    
    func saveCurrentNoti(Token: String) {
        defaults.setValue(Token, forKey: UserDefaultsConstants.Noti)
    }
    
    func getCurrentNoti() -> String? {
        return defaults.string(forKey: UserDefaultsConstants.Noti)
    }
    
    func RemoveProfileModel() {
        return defaults.removeObject(forKey: "ProfileModel")
    }
    
    
    func getRefreshToken() -> String? {
        return defaults.string(forKey: UserDefaultsConstants.refreshToken)
    }
    
    func saveRefreshToken(refreshToken : String) {
        defaults.setValue(refreshToken, forKey: UserDefaultsConstants.refreshToken)
    }
    
    
   
}
