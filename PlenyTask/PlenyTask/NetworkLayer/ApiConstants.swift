//
//  ApiConstants.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

struct ApiConstants {
    
    static let baseURL = "https://dummyjson.com/"
    static let loginPath = "auth/login"
    static let postsPath = "posts"
}

extension ApiConstants {
    enum Errors: String, Error {
        case genericError
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
