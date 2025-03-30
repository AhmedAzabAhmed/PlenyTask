//
//  LoginScreen.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var coordinator = Coordinator()
    @StateObject var viewModel = LoginViewModel()
    @State private var isPasswordVisible = false
    
    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            VStack(spacing: 20) {
                // Welcome Title
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                // Username Field
                VStack(alignment: .leading, spacing: 5) {
                    Text("User Name")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("Enter your user name", text: $viewModel.username)
                        .padding(10)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                
                // Password Field
                VStack(alignment: .leading, spacing: 5) {
                    Text("Password")
                        .font(.headline)
                        .foregroundColor(.gray)
                    HStack {
                        if isPasswordVisible {
                            TextField("Enter your password", text: $viewModel.password)
                            
                        } else {
                            SecureField("Enter your password", text: $viewModel.password)
                            
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(10)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                
                // Sign In Button
                Button(action: {
                    Task {
                        await viewModel.login()
                        if viewModel.isLoggedIn {
                            if viewModel.isLoggedIn {
                                coordinator.showHome()
                            }
                        }
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                    } else {
                        Text("Sign in")
                    }
                    
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
                .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty) // Disable button if fields are empty
            }
            .padding()
            .navigationDestination(for: Route.self) { value in
                coordinator.navigationDistination(route: value)
            }
        }
    }
}

#Preview {
    LoginScreen()
}
