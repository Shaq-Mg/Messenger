//
//  MessageViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 19/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class MessagesViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var isLoggedOut = true
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isLoggedOut = Auth.auth().currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users")
            .document(uid).getDocument { documentSnapshot, error in
                if let error = error {
                    print("Failed to fetch current user:", error)
                    return
                }
                guard let data = documentSnapshot?.data() else { return }
                print(data)
            }
    }
}
