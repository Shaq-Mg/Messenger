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
    @DocumentID var id: String?
    let fromId, toId: String
    let username, photoImageUrl, email, text: String
    let timestamp: Date
    
    init(data: [String: Any]) {
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.username = data[FirebaseConstants.username] as? String ?? ""
        self.photoImageUrl = data[FirebaseConstants.photoImageUrl] as? String ?? ""
        self.email = data[FirebaseConstants.email] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
        self.timestamp = data["timestamp"] as? Date ?? Date()
    }
}
