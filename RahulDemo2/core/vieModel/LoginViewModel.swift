//
//  LoginViewModel.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 08/05/25.
//

import Foundation


class LoginViewModel : ObservableObject {
    
   // @Published var isLoggedIn: Bool = UserDefaultsManager.shared.isLoggedIn
    
    
    func performLogin() {
            // Dummy user data
            let dummyUser = User(
                id: 1,
                name: "John Doe",
                mobile: "9876543210",
                email: "john@example.com",
                gender: "Male",
                dob: "1990-01-01",
                occupation: "Developer",
                createdAt: "2025-05-08"
            )
            
            // Save to UserDefaults
            UserDefaultsManager.shared.saveLoggedInUser(dummyUser)
            UserDefaultsManager.shared.isLoggedIn = true
            
            // Update state
           // isLoggedIn = true
        }
        
    
    func logout() {
            UserDefaultsManager.shared.logoutUser()
           // isLoggedIn = false
        }
    
}
