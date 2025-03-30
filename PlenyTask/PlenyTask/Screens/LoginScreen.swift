//
//  LoginScreen.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                Button {
                    coordinator.showHome()
                } label: {
                    Text("Login")
                }
                
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
