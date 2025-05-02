//
//  LoginFlowView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 29/04/25.
//

import SwiftUI

struct LoginFlowView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        LoginView()
           
     }
}

#Preview {
    LoginFlowView()
}
