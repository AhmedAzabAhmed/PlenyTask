//
//  AuthUseCase.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

final class AuthUseCase {
    let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepositoryImplementation()) {
        self.authRepository = authRepository
    }
    
    func login(email: String, password: String) async throws -> Bool {
        return try await authRepository.login(username: email, password: password)
    }
}
