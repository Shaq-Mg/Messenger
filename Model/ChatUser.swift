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
}
