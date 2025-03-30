//
//  AuthRepositoryImplementation.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

final class AuthRepositoryImplementation: AuthRepository {
    private let networkManager = NetworkManager.shared
    private let dataProcessor = DataProcessor.shared
    
    // MARK: - Token Refresh
    func refreshTokenIfNeeded() async throws {
        guard let refreshToken = KeychainHelper.getRefreshToken() else {
            throw NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No refresh token available"])
        }
        
        guard let url = URL(string: ApiConstants.baseURL + ApiConstants.refreshTokenPath) else {
            throw URLError(.badURL)
        }
        
        let body = RefreshTokenRequest(refreshToken: refreshToken)
        let bodyData = try dataProcessor.encode(body)
        
        let rawData = try await networkManager.request(
            url: url,
            method: .post,
            body: bodyData
        )
        
        let result = try dataProcessor.decode(rawData, to: RefreshTokenResponse.self)
        
        // Save the new access token securely
        KeychainHelper.saveAccessToken(result.accessToken)
        
        // Optionally save the new refresh token if it's returned
        if let newRefreshToken = result.refreshToken {
            KeychainHelper.saveRefreshToken(newRefreshToken)
        }
    }
    
    // MARK: - Login (unchanged, for reference)
    func login(username: String, password: String) async throws -> Bool {
        guard let url = URL(string: ApiConstants.baseURL + ApiConstants.loginPath) else {
            throw URLError(.badURL)
        }
        
        let body = AuthRequest(username: username, password: password)
        let bodyData = try dataProcessor.encode(body)
        let rawData = try await networkManager.request(
            url: url,
            method: .post,
            body: bodyData
        )
        
        let result = try dataProcessor.decode(rawData, to: LoginResponse.self)
        UserDefaults.standard.setStruct(result, forKey: UserDefaultsKeys.profile.rawValue)
        KeychainHelper.saveAccessToken(result.accessToken)
        KeychainHelper.saveRefreshToken(result.refreshToken)
        
        return true
    }
}
