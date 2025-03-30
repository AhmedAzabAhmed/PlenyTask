//
//  KeychainHelper.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

// MARK: - Keychain Helper (Updated)
final class KeychainHelper {
    static func saveAccessToken(_ token: String) {
        save(token, service: "access-token")
    }
    
    static func saveRefreshToken(_ token: String) {
        save(token, service: "refresh-token")
    }
    
    static func getAccessToken() -> String? {
        return get(service: "access-token")
    }
    
    static func getRefreshToken() -> String? {
        return get(service: "refresh-token")
    }
    
    private static func save(_ token: String, service: String) {
        let data = token.data(using: .utf8)!
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecValueData: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private static func get(service: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
