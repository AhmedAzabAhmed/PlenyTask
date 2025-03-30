//
//  AuthRepository.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

protocol AuthRepository {
    func login(username: String, password: String) async throws -> Bool
    func refreshTokenIfNeeded() async throws
}
