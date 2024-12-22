//
//  MainMessagesViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class MainMessagesViewModel: ObservableObject {
    @Published var isUserCurrrentlyLoggedOut = true
    @Published var showNewMessageScreen = false
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var recentMessages = [RecentMessage]()
    
    let manager = FirebaseManager.shared
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrrentlyLoggedOut = Auth.auth().currentUser?.uid == nil
        }
        manager.fetchCurrentUser()
        
        fetchRecentMessages()
    }
    
    private func fetchRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("recent_messages").document(uid).collection("messages").order(by: "timestamp").addSnapshotListener { querySnapshot, error in
            if let error = error {
                self.errorMessage = "Failed to listen for recent message: \(error)"
                print(error)
                return
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                let docId = change.document.documentID
                if let index = self.recentMessages.firstIndex(where: { rm in
                    return rm.id == docId
                }) {
                    self.recentMessages.remove(at: index)
                }
                if let rm = try? change.document.data(as: RecentMessage.self) {
                    self.recentMessages.insert(rm, at: 0)
                }
            })
        }
    }
}

