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
    @Published var chatUser: ChatUser?
    @Published var errorMessage = ""
    @Published var isLoggedOut = true
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isLoggedOut = Auth.auth().currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users")
            .document(uid).getDocument { documentSnapshot, error in
                if let error = error {
                    print("Failed to fetch current user:", error)
                    return
                }
                guard let data = documentSnapshot?.data() else {
                    self.errorMessage = "No data found"
                    return
                }
                let uid = data["uid"] as? String ?? ""
                let photoImageUrl = data["photoImageUrl"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                
                self.chatUser = ChatUser(uid: uid, photoImageUrl: photoImageUrl, username: username, email: email, password: password)
            }
    }
}
