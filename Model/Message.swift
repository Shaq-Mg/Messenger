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
    let timestamp: Timestamp
}
