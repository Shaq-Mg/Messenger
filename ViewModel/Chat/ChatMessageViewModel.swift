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
    let db = Firestore.firestore()
    
    init() {
        fetchMessage()
    }
    private func fetchMessage() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents \(String(describing: error))")
                return
            }
            self.messages = documents.compactMap({ document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding documnet into message: \(error)")
                    return nil
                }
            })
        }
    }
    
    func sendMessage(text: String) {
        do {
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            try db.collection("meesages").document().setData(from: newMessage)
        } catch {
            print("Error adding message to firestore: \(error)")
        }
    }
}
