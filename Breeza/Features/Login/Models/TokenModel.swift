//
//  TokenModel.swift
//  Breeza
//
//  Created by Amr Ali on 27/02/2024.
//

struct TokenModel: Codable {
    var token: String?
    var refreshToken : String?
    var mustChangePassword : Bool?
    var title : String?
    var fullName : String?
}
