//
//  ChatUser.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import Foundation

struct ChatUser: Identifiable {
    var id: String { uid }
    let uid, photoImageUrl, username, email: String
    
    init(data: [String:Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.photoImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
