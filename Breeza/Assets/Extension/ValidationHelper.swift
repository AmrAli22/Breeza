////
////  ValidationHelper.swift
////  Mustafid
////
////  Created by Amr Ali on 04/09/2022.
////
//
//import Foundation
//
//class Validation: NSObject {
//    
//   
//    func isValidUserName(userNameString: String) -> Bool {
//        var returnValue = true
//        let userNameRegEx = "^[a-zA-Z\\s]+$"
//        
//        do {
//            let regex = try NSRegularExpression(pattern: userNameRegEx)
//            let nsString = userNameString as NSString
//            let results = regex.matches(in: userNameString, range: NSRange(location: 0, length: nsString.length))
//            if results.count == 0
//            {
//                returnValue = false
//            }
//            
//        } catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            returnValue = false
//        }
//        return  returnValue
//    }
//    
//    func isValidEmailAddress(emailAddressString: String) -> Bool {
//        
//        var returnValue = true
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
//        do {
//            let regex = try NSRegularExpression(pattern: emailRegEx)
//            let nsString = emailAddressString as NSString
//            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
//            
//            if results.count == 0
//            {
//                returnValue = false
//            }
//            
//        } catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            returnValue = false
//        }
//        return  returnValue
//    }
//    
//    func isValidPhoneNumber(phoneString: String) -> Bool {
//        var returnValue = true
//        //let phoneRegEx = "^[+]?[0-9]{\(10),\(15)}$"
//        let phoneRegEx = "(01)[0-9]{9}"
//        do {
//            let regex = try NSRegularExpression(pattern: phoneRegEx)
//            let nsString = phoneString as NSString
//            let results = regex.matches(in: phoneString, range: NSRange(location: 0, length: nsString.length))
//            
//            if results.count == 0
//            {
//                returnValue = false
//            }
//            
//        } catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            returnValue = false
//        }
//        return  returnValue
//    }
//    
//    func isValidSaudiPhoneNumber(phoneString: String) -> Bool {
//        var returnValue = true
//        let phoneRegExSaudi = #"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$"#
//       do {
//            let regex = try NSRegularExpression(pattern: phoneRegExSaudi)
//            let nsString = phoneString as NSString
//            let results = regex.matches(in: phoneString, range: NSRange(location: 0, length: nsString.length))
//            
//            if results.count == 0
//            {
//                returnValue = false
//            }
//            
//        } catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            returnValue = false
//        }
//        return  returnValue
//    }
//    
//    
//    func isValidCardNumber(number: String) -> Bool {
//        var returnValue = true
//        let cardNumber = "^[0-9]{\(16),\(16)}$"
//        do {
//            let regex = try NSRegularExpression(pattern: cardNumber)
//            let nsString = number as NSString
//            let results = regex.matches(in: number, range: NSRange(location: 0, length: nsString.length))
//            
//            if results.count == 0
//            {
//                returnValue = false
//            }
//            
//        } catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            returnValue = false
//        }
//        return  returnValue
//    }
//    
//    func isValidOptionalPhoneNumber(OptiphoneString: String, min: Int, max: Int) -> Bool {
//        var returnValue = true
//        let phoneRegEx = "^[+]?[0-9]{\(min),\(max)}$"
//        do {
//            let regex = try NSRegularExpression(pattern: phoneRegEx)
//            let nsString = OptiphoneString as NSString
//            let results = regex.matches(in: OptiphoneString, range: NSRange(location: 0, length: nsString.length))
//            
//            if results.count == 0
//            {
//                returnValue = false
//            }
//            
//        } catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            returnValue = false
//        }
//        return  returnValue
//    }
//    
//    func isValidPassword(passwordString: String) -> Bool {
//        
//        var returnValue = true
//        
//        
//        if passwordString.count >= 6 {
//            returnValue = true
//        }else{
//            returnValue = false
//        }
//
//        return  returnValue
//    }
//
//    
//}
