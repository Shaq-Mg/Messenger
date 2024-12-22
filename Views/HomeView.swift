//
//  HomeView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authVM: AuthenticationViewModel
    @EnvironmentObject private var mainMessagesVM: MainMessagesViewModel
    @State var selectedTab: TabState = .messages
    @State private var isMenuShowing = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if selectedTab == .messages {
                MainMessagesView(isMenuShowing: $isMenuShowing)
                    .environmentObject(mainMessagesVM)
            }
            
            if selectedTab == .settings {
                SettingsView(isMenuShowing: $isMenuShowing)
                    .environmentObject(authVM)
            }
            
            if isMenuShowing {
                CustomTabView(selectedTab: $selectedTab, isMenuShowing: $isMenuShowing)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthenticationViewModel())
        .environmentObject(MainMessagesViewModel())
}
