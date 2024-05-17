//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage = ""
    
    @Published var email = ""
    @Published var username = ""
    @Published var photoURL = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.user = authResult?.user
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch let signOutError as NSError {
            self.errorMessage = signOutError.localizedDescription
        }
    }
}
