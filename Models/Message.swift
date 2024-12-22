//
//  Message.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI
import FirebaseFirestore

struct ChatMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId, fromId, toId, text: String
    
    init(documentId: String, data: [String : Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
    }
    
    static let preview = ChatMessage(documentId: "", data: [FirebaseConstants.fromId: "saka@gmail.com", FirebaseConstants.text: "Good morning"])
    
}

struct RecentMessage: Codable ,Identifiable {
    
    @DocumentID var id: String?
    let text, email, fromId, toId, profileImageUrl: String
    let timestamp: Date
}
