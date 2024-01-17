//
//  ErrorResponse.swift
//  Breeza
//
//  Created by Amr Ali on 17/01/2024.
//

import Foundation

struct ObjectResponse<T: Codable> : Codable {
    var code: Int?
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}

struct ArrayResponse<T: Codable> : Codable {
    var code: Int?
    var message: String?
    var data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}

struct ErrorResponse: Codable {
    var code: Int?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
    
    init(error: [String : Any]) {
        code = error["code"] as? Int
        message = error["message"] as? String
    }
    
    init(message: String) {
        code = nil
        self.message = message
    }
    
    init(code: Int , message : String) {
        self.code = code
        self.message = message
    }
}

