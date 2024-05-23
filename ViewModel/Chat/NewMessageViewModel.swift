//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 23/05/2024.
//

import Foundation
import FirebaseFirestore

class NewMessageViewModel: ObservableObject {
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    let manager = FirebaseManger.shared
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        manager.firestore.collection("users").getDocuments { documentsSnapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch users: \(error)"
                print("Failed to fetch users: \(error)")
                return
            }
            documentsSnapshot?.documents.forEach({ snapshot in
                let data = snapshot.data()
                let user = ChatUser(data: data)
                if user.id != self.manager.auth.currentUser?.uid {
                    self.users.append(.init(data: data))
                }
            })
        }
    }
}
