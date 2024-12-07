//
//  RootView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var mainMessagesVM: MainMessagesViewModel
    @State var selectedTab: TabState = .messages
    @State private var isMenuShowing = false
    var body: some View {
        ZStack(alignment: .bottom) {
            if selectedTab == .messages {
                MainMessagesView(isMenuShowing: $isMenuShowing)
                    .environmentObject(mainMessagesVM)
            }
            
            if selectedTab == .settings {

            }
            
            if isMenuShowing {
                CustomTabView(selectedTab: $selectedTab, isMenuShowing: $isMenuShowing)
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(MainMessagesViewModel())
}
