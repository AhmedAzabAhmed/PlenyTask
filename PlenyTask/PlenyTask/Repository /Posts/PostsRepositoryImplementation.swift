//
//  PostsRepositoryImplementation.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

final class PostsRepositoryImplementation: PostsRepository {
    private let networkManager = NetworkManager.shared
    private let dataProcessor = DataProcessor.shared
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepositoryImplementation()) {
        self.authRepository = authRepository
    }
    
    // MARK: - Fetch Posts
    func fetchPosts(skip: Int, limit: Int) async throws -> [Post] {
        try await ensureTokenIsValid()
        
        guard let url = URL(string: "\(ApiConstants.baseURL)posts?skip=\(skip)&limit=\(limit)") else {
            throw URLError(.badURL)
        }
        
        let headers = [
            "Authorization": "Bearer \(KeychainHelper.getAccessToken() ?? "")"
        ]
        
        let rawData = try await networkManager.request(
            url: url,
            method: .get,
            headers: headers
        )
        
        let result = try dataProcessor.decode(rawData, to: PostsResponse.self)
        return result.posts
    }
    
    // MARK: - Search Posts
    func searchPosts(query: String, skip: Int, limit: Int) async throws -> [Post] {
        try await ensureTokenIsValid()
        
        guard let url = URL(string: "\(ApiConstants.baseURL)posts/search?q=\(query)&skip=\(skip)&limit=\(limit)") else {
            throw URLError(.badURL)
        }
        
        let headers = [
            "Authorization": "Bearer \(KeychainHelper.getAccessToken() ?? "")"
        ]
        
        let rawData = try await networkManager.request(
            url: url,
            method: .get,
            headers: headers
        )
        
        let result = try dataProcessor.decode(rawData, to: PostsResponse.self)
        return result.posts
    }
    
    // MARK: - Token Validation
    private func ensureTokenIsValid() async throws {
        guard KeychainHelper.getAccessToken() != nil else {
            throw NSError(
                domain: "AuthError",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "No access token available"]
            )
        }
        
        try await authRepository.refreshTokenIfNeeded()
    }
}
