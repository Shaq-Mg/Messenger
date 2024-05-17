//
//  ChatUser.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import Foundation

struct ChatUser: Identifiable {
    var id = UUID()
    let photoURL: String
    let username: String
    let email: String
    let password: String
}
