//
//  SaudiIDNumberValidator.swift
//  iDriver App
//
//  Created by Hesham Donia on 26/05/2021.
//

import Foundation


public enum NationaltyType {
    case saudi
    case nonSaudi
    case none
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .saudi: return "Valid Number, Saudi Nationality"
        case .nonSaudi: return "Valid Number, Non-Saudi Nationality"
        case .none: return "Unknown Nationality"
        }
    }
}

public enum ValidateSAIDError : Error, CustomStringConvertible {
    case unknown
    case lengthIssue
    case initialNumberError
    case integersOnly
    case nonValidID
    
    public var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .unknown: return "Unknown Error"
        case .lengthIssue: return "ID must be 10 digits"
        case .initialNumberError: return "ID must start with 1 or 2 only"
        case .integersOnly: return "Enter only integer numbers"
        case .nonValidID: return "ID is not valid"
        }
    }
}


public struct ValidateSAID {
    
    public static func check(_ id: String) -> NationaltyType {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        
        // check if the given String is exactly an Int
        guard
            let number = formatter.number(from: id),
            Int(exactly: number) != nil,
            let idString = formatter.string(from: number)
        else {
            return .none
        }
        
        // check length of the ID
        if (idString.count != 10) {
            return .nonSaudi
        }
        
        // get first character from ID String
        guard let first = idString.first else {
            return .nonSaudi
        }
        
        // convert first charachter to String
        let firstStringValue = String(first)
        // try to cast firstStringValue to Int
        guard let type = Int(firstStringValue) else {
            return .nonSaudi
        }
        
        // if ID number not starting with 1 or 2 throw error
        if (type != 1 && type != 2) {
            return .nonSaudi
        }
        
        let sum = idString.enumerated().reduce(0) { (sum, item) -> Int in
            let i = item.offset
            var sumTemp = sum
            if (i % 2 == 0) {
                let ZFOdd = String(format: "%02d", Int(String(idString.charAt(at: i)))! * 2)
                sumTemp += Int(String(ZFOdd.charAt(at: 0)))! + Int(String(ZFOdd.charAt(at: 1)))!
            } else {
                sumTemp += Int(String(idString.charAt(at: i)))!
            }
            return sumTemp
        }
        
        if (sum % 10 != 0) {
            return .nonSaudi
        } else if  (type == 1) {
            return NationaltyType.saudi
        } else if  (type == 2) {
            return NationaltyType.nonSaudi
        } else {
            return .nonSaudi
        }
    }
}

extension String {
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
}
