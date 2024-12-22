//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        Firestore.firestore().collection("users").getDocuments { documentSnapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch users: \(error)"
                print("Failed to fetch users: \(error)")
                return
            }
            
            documentSnapshot?.documents.forEach({ snapshot in
                let data = snapshot.data()
                let user = User(data: data)
                if user.uid != Auth.auth().currentUser?.uid {
                    self.users.append(.init(data: data))
                }
            })
        }
    }
}
