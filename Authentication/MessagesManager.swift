//
//  MessagesManager.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    let db = Firestore.firestore()
    
    func getMessage() {
        db.collection("Messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error)")
                return
            }
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }
        }
    }
}
