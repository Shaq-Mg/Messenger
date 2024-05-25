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
    @Published var recentMessages: [Message] = []
    @Published var chatUser: ChatUser?
    @Published var errorMessage = ""
    @Published var isLoggedOut = true
    @Published var navigateToChatMessageView = true
    
    let manager = FirebaseManger.shared
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoggedOut = Auth.auth().currentUser?.uid == nil
        }
        fetchCurrentUser()
        
        fetchRecentMessages()
    }
    
    private func fetchRecentMessages() {
        guard let uid = manager.auth.currentUser?.uid else { return }
        manager.firestore.collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for recent messages: \(error)"
                    return
                }
                querySnapshot?.documentChanges.forEach( { change in
                    let docId = change.document.documentID
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.id == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    do {
                        if let rm = try? change.document.data(as: Message.self) {
                            self.recentMessages.insert(rm, at: 0)
                        }
                    } catch {
                        print(error)
                    }
                })
            }
    }

    func fetchCurrentUser() {
        guard let uid = manager.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        manager.firestore.collection("users")
            .document(uid).getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user: \(error)"
                    print("Failed to fetch current user:", error)
                    return
                }
                guard let data = snapshot?.data() else {
                    self.errorMessage = "No data found"
                    return
                }
                self.chatUser = .init(data: data)
            }
    }
}
