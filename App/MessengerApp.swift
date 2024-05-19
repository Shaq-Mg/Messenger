//
//  MessengerApp.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI
import FirebaseCore

@main
struct MessengerApp: App {
    @StateObject private var vm = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            MessagesView()
                .environmentObject(vm)
        }
    }
}
