//
//  Message.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
