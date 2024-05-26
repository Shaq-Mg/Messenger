//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

final class AuthenticationViewModel: ObservableObject {
    @Published var loginStatusMessage = ""
    @Published var isLoggedOut = true
    @Published var showSignOutAlert = false
    @Published var showDeleteAccountAlert = false
    
    @Published var image: UIImage?
    @Published var selectedImage: PhotosPickerItem?
    @Published var email = ""
    @Published var username = ""
    @Published var photoImageUrl = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    let manager = FirebaseManger.shared
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoggedOut = Auth.auth().currentUser?.uid == nil
        }
    }
    
    func createAccount() {
        manager.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                self.loginStatusMessage = "Failed to create user: \(error)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            //            self.persistImageToStorage()
            self.persistImageToStorage()
        }
    }
    
    func signOut() {
        isLoggedOut.toggle()
        try? manager.auth.signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = manager.auth.currentUser else { return
            // handle error here
        }
        try await user.delete()
    }
    
//    private func createNewUser() {
//        guard let uid = manager.auth.currentUser?.uid else { return }
//        let userData = ["email": self.email, "username": self.username, "password": self.password, "uid": uid]
//        manager.firestore.collection("users")
//            .document(uid).setData(userData, merge: false) { error in
//                if let error = error {
//                    print(error)
//                    self.loginStatusMessage = "Failed to store user information to database: \(error)"
//                    return
//                }
//                print("Success")
//            }
//    }
    
    private func persistImageToStorage() {
        guard let uid = manager.auth.currentUser?.uid else { return }
        let ref = manager.storage.reference(withPath: uid)
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
        guard let uid = manager.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "username": self.username, "password": self.password, "uid": uid]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData) {  error in
                if let error = error {
                    print(error)
                    self.loginStatusMessage = "Failed to store user information to database \(error)"
                    return
                }
                print("Success")
            }
    }
}
