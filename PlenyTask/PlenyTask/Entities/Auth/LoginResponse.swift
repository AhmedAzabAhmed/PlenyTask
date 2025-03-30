//
//  LoginResponse.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

struct LoginResponse: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let accessToken: String
    let refreshToken: String
    
    // If the API uses different JSON keys, use CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case firstName = "firstName"  // If JSON uses camelCase (matches exactly)
        case lastName = "lastName"   // If JSON uses camelCase (matches exactly)
        case gender
        case image
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
