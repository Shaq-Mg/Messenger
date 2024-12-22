//
//  AuthenticationViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    @Published var fileURL: URL? = nil
    
    @Published var isUserCurrrentlyLoggedOut = true
    @Published var errorMessage = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    let manager = FirebaseManager.shared
    
    init() {
        manager.fetchCurrentUser()
        DispatchQueue.main.async {
            self.isUserCurrrentlyLoggedOut = Auth.auth().currentUser?.uid == nil
        }
    }
    
    func clearLoginInformation() {
        email = ""
        password = ""
        confirmPassword = ""
        errorMessage = ""
        selectedItem = nil
        selectedImageData = nil
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign in user:", error)
                self.errorMessage = "Failed to sign in user: \(error)"
                return
            }
            print("Successfully signed in user \(result?.user.uid ?? "")")
            self.errorMessage = "Successfully signed in user \(result?.user.uid ?? "")"
            self.isUserCurrrentlyLoggedOut = false
        }
    }
    
    func createNewAccount() {
        if self.selectedImageData == nil {
            self.errorMessage = "You must select an profile image"
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                self.errorMessage = "Failed to create user: \(error)"
                return
            }
            print("Successfully created user \(result?.user.uid ?? "")")
            self.errorMessage = "Successfully created user \(result?.user.uid ?? "")"
            self.manager.createAccount()
            self.isUserCurrrentlyLoggedOut = false
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        isUserCurrrentlyLoggedOut = true
    }
}

extension AuthenticationViewModel {
    
    func saveImageToFileManager(data: Data) {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".jpg"
        let filePath = directory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: filePath)
            fileURL = filePath
            print("Image saved at \(filePath)")
            self.errorMessage = "Successfully stored image with url: \(filePath)"
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            self.errorMessage = "Failed to push image to storage: \(error)"
        }
    }
}
