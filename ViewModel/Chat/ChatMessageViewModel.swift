//
//  ChatMessageViewModel.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatMessageViewModel: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published var errorMessage = ""
    @Published var chatText = ""
    @Published var messageCount = 0
    
    let scrollToId =  "Empty"
    let chatUser: ChatUser?
    let manager = FirebaseManger.shared
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    private func fetchMessages() {
        guard let fromId = manager.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        manager.firestore.collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    print(error)
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.messages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
                
                DispatchQueue.main.async {
                    self.messageCount += 1
                }
            }
    }
    
    func sendMessage() {
        guard let fromId = manager.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        
        let document = manager.firestore.collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = [FirebaseConstants.fromId: fromId, FirebaseConstants.toId: toId, FirebaseConstants.text: self.chatText, FirebaseConstants.timestamp: Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore \(error)"
                return
            }
            print("Successfully saved current user sending message")
            
            self.persistRecentMessage()
            self.chatText = ""
            self.messageCount += 1
        }
        let recieverMessageDocument = manager.firestore.collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recieverMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore \(error)"
                return
            }
            print("Successfully saved current user sending message")
        }
    }
    
    private func persistRecentMessage() {
        guard let chatUser = chatUser else { return }
        guard let uid = manager.auth.currentUser?.uid else { return }
        guard let toId = self.chatUser?.uid else { return }

        let document = manager.firestore
            .collection("recent_message")
            .document(uid)
            .collection("messages")
            .document(toId)

        let data = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
            FirebaseConstants.photoImageUrl: chatUser.photoImageUrl,
            FirebaseConstants.username: chatUser.username
        ] as [String : Any]

        // I need to save another similiar dictionary for the recipient of this message...how?
        document.setData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to save recent message: \(error)"
                return
            }
        }
    }
}
