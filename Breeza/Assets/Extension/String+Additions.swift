//
//  String+Additions.swift
//  Damin
//
//  Created by Amr Ali on 17/08/2023.
//


import Foundation
import UIKit
import Localize_Swift

extension String {
    
    public var arToEnDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
}

extension String {
    
    func safeUrl() -> String {
        let safeURL = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return safeURL
    }
    
    var charactersArray: [Character] {
            return Array(self)
        }
    
    /// SwifterSwift: Random string of given length.
    ///
    ///        String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            let randomIndex = arc4random_uniform(UInt32(base.count))
            let randomCharacter = base.charactersArray[Int(randomIndex)]
            randomString.append(randomCharacter)
        }
        return randomString
    }
}


// MARK: - Validation
extension Optional where Wrapped == String {

    var isNilOrEmpty: Bool {
        self == nil || self == ""
    }
}
// MARK: - Password Validation
extension String {
    
    var isValidPassword: Bool {
        return validateWithRegex(regex: "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
    }
    
    // NSPredicate
    func validateWithRegex(regex: String)->Bool {
        let prediction = NSPredicate(format:"SELF MATCHES %@", regex)
        return prediction.evaluate(with: self)
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

}
