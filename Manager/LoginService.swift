//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

final class LoginService: ObservableObject {
    @Published var user: User?
    @Published var loginStatusMessage = ""
    @Published var isLoggedOut = true
    @Published var isLoading = false
    
    @Published var email = ""
    @Published var username = ""
    @Published var photoURL = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            loginStatusMessage = "Email and password cannot be empty."
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                self.loginStatusMessage = "Failed to create user: \(error)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            return
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign in user:", error)
                self.loginStatusMessage = "Failed to sign in user: \(error)"
                return
            }
            print("Successfully signed in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully signed in as user: \(result?.user.uid ?? "")"
            return
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            self.loginStatusMessage = "Error: failed to sign out user"
        }
    }
}
