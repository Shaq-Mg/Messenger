//
//  RootView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        if authViewModel.isUserCurrrentlyLoggedOut {
            LoginView()
        } else {
            HomeView()
        }
    }
}

#Preview {
    NavigationStack {
        RootView()
            .environmentObject(AuthenticationViewModel())
    }
}
