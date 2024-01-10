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
    
    
    
//    // Function to save an array of objects to UserDefaults
//     func saveRegisterModel(_ registerModel : RegisterModel) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(registerModel) {
//            UserDefaults.standard.set(encoded, forKey: "registerModel")
//        }
//    }
//    
//    // Function to retrieve an array of objects from UserDefaults
//     func getRegisterModel() -> RegisterModel? {
//        if let savedData = UserDefaults.standard.data(forKey: "registerModel") {
//            let decoder = JSONDecoder()
//            if let people = try? decoder.decode(RegisterModel.self, from: savedData) {
//                return people
//            }
//        }
//        return nil
//    }
//    
//    func RemoveRegisterModel() {
//        return defaults.removeObject(forKey: "registerModel")
//    }
//    
//    // Function to save an array of objects to UserDefaults
//     func saveProfileModel(_ profileModel : ProfileModel) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(profileModel) {
//            UserDefaults.standard.set(encoded, forKey: "ProfileModel")
//        }
//    }
//    
//    // Function to retrieve an array of objects from UserDefaults
//     func getProfileModel() -> ProfileModel? {
//        if let savedData = UserDefaults.standard.data(forKey: "ProfileModel") {
//            let decoder = JSONDecoder()
//            if let people = try? decoder.decode(ProfileModel.self, from: savedData) {
//                return people
//            }
//        }
//        return nil
//    }
    
    func RemoveProfileModel() {
        return defaults.removeObject(forKey: "ProfileModel")
    }
    
   
}
