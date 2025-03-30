//
//  Coordinator.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import SwiftUI

class Coordinator: ObservableObject {
    
    @Published var routes: [Route] = []
    
    
    func show(route: Route) {
        routes.append(route)
    }
    
    func showHome() {
        routes = [.home]
    }
    
    func navigationDistination(route: Route) -> some View {
        let view = route.view().environmentObject(self)
        return view
    }
    
    func pop() {
        routes.removeLast()
    }
    
}

enum Route: Hashable {
    
    case home
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .home:
            HomeScreen()
                .navigationBarBackButtonHidden()
        }
    }
}
