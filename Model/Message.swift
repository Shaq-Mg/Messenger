//
//  Message.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
    var id: String { documentId }
    let documentId: String
    let fromId, toId, text: String
    let timestamp: Date
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
        self.timestamp = data["timestamp"] as? Date ?? Date()
    }
}
