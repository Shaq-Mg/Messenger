//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

final class LoginService: ObservableObject {
    @Published var user: User?
    @Published var loginStatusMessage = ""
    @Published var isLoggedOut = true
    @Published var showSignOutAlert = false
    
    @Published var image: UIImage?
    
    @Published var email = ""
    @Published var username = ""
    @Published var photoURL = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    init() {
        
    }
    
    func signUp() {
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
            
            self.persistImageToStorage()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            self.loginStatusMessage = "Error: failed to sign out user\(Auth.auth().currentUser?.uid ?? "")"
        }
    }
    private func persistImageToStorage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                self.loginStatusMessage = "Failed to push image to storage: \(error)"
                return
            }
            ref.downloadURL { url, error in
                if let error = error {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(error)"
                    return
                }
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString ?? "")
                
                guard let url = url else { return }
                self.storeUserInformation(profileImageUrl: url)
            }
        }
    }
    
    private func storeUserInformation(profileImageUrl: URL) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["email": self.email, "username": self.username, "password": self.password, "uid": uid, "profileImageUrl": profileImageUrl.absoluteString]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData) {  error in
                if let error = error {
                    print(error)
                    self.loginStatusMessage = "\(error)"
                    return
                }
                print("Success")
            }
    }
}
