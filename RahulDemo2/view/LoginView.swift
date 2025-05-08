//
//  LoginNewView.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 24/04/25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
       @EnvironmentObject var appState: AppState
    
    @EnvironmentObject var loginViewModel : LoginViewModel
   
    var body: some View {
        
        VStack(spacing:20){
            Text("Login")
                .font(.largeTitle)
                .padding()
            
            Button("Login") {
                
                loginViewModel.performLogin()
                appState.login()
                
               // coordinator.completeLogin()  // coordinator will observe this and trigger completeLogin()
            }
            //  coordinator.navigate(to: HomeFlow.dishDetails.asDestination())
            Button("Forgot Password") {
                coordinator.navigate(to: .login(.forgotPassword))
            }
            
            Button("Sign Up") {
                coordinator.navigate(to: .login(.signUp))
            }
            
        }
        
        
        
    }
}

struct ForgotPasswordView: View {
    var body: some View {
        Text("Forgot Password")
            .font(.largeTitle)
            .padding()
    }
}

struct CreateAccountView: View {
    let name: String
    var body: some View {
        Text("Create Account for \(name)")
            .font(.largeTitle)
            .padding()
    }
}

struct EmailSentView: View {
    var body: some View {
        Text("Email Sent")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    LoginView()
}

#Preview {
    ForgotPasswordView()
}

#Preview {
    CreateAccountView(name: "Alice")
}

#Preview {
    EmailSentView()
}
