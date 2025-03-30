//
//  LoginViewModel.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

class LoginViewModel: ObservableObject {
    // MARK: - Input Fields
    @Published var username = ""
    @Published var password = ""
    
    // MARK: - UI State
    @Published private(set) var isLoading = false
    @Published private(set) var isLoggedIn = false
    
    
    // MARK: - Dependencies
    private let authUseCase: AuthUseCase
    
    init(authUseCase: AuthUseCase = AuthUseCase()) {
        self.authUseCase = authUseCase
    }
    
    // MARK: - Actions
    @MainActor
    func login() async {
        isLoading = true
        
        do {
            let result = try await authUseCase.login(email: username, password: password)
            isLoggedIn = result
            if !result {
                //TODO: show error Invalid credentials
            }
            
        } catch {
            //TODO: handle error
            print( error.localizedDescription)
        }
        
        isLoading = false
    }
}
