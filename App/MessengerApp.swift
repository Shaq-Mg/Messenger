//
//  MessengerApp.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct MessengerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthenticationViewModel()
    @StateObject private var mainMessageViewModel = MainMessagesViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .environmentObject(authViewModel)
                    .environmentObject(mainMessageViewModel)
            }
        }
    }
}
