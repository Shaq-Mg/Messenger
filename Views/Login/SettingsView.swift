//
//  SettingsView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authVM: AuthenticationViewModel
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        List {
            Section("Account") {
                Button("Sign out") {
                    try? authVM.signOut()
                }
                .font(.headline)
                .foregroundStyle(.mint)
            }
        }
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShowMenuButtonView(isMenuShowing: $isMenuShowing)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(isMenuShowing: .constant(false))
            .environmentObject(AuthenticationViewModel())
    }
}
