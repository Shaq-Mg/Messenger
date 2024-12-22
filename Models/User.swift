//
//  User.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import Foundation

struct User: Identifiable {
    
    var id: String { uid }
    
    let uid, email, profileImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
