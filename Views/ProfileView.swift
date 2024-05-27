//
//  ProfileView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 19/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        List {
            Section(header: Text("Profile image")) {
                HStack {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.mint)
                        .shadow(radius: 2)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                        )
                    Text("Saka7@gmail.com")
                        .font(.headline)
                }
            }
            
            AccountInfoSection()
            Button {
                vm.showSignOutAlert.toggle()
                dismiss()
            } label: {
                Text("Sign Out")
                    .font(.headline)
            }
            Button {
                vm.showDeleteAccountAlert.toggle()
            } label: {
                Text("Delete Acount")
                    .foregroundStyle(.red)
                    .font(.headline)
            }
        }
        .navigationTitle("My Account")
        .actionSheet(isPresented: $vm.showDeleteAccountAlert, content: {
            .init(title: Text("Delete").bold(), message: Text("Are you sure that you want to delete your account?"), buttons: [
                .destructive(Text("Yes").bold(), action: {
                    Task {
                        try await vm.deleteAccount()
                    }
                    vm.loginStatusMessage = ""
                }),
                .cancel()
            ])
        })
        .actionSheet(isPresented: $vm.showSignOutAlert, content: {
            .init(title: Text("Sign Out").bold(), message: Text("Are you sure that you want to sign out your account?"), buttons: [
                .destructive(Text("Yes").bold(), action: {
                    vm.signOut()
                    vm.loginStatusMessage = ""
                }),
                .cancel()
            ])
        })
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthenticationViewModel())
    }
}

struct AccountInfoSection: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    var body: some View {
        Section(header: Text("Account Info")) {
            LabeledContent {
                Text(vm.username)
            } label: {
                Text("Usernane")
            }
            LabeledContent {
                Text(vm.email)
            } label: {
                Text("Email")
            }
            
            Button {
                
            } label: {
                Text("Update info")
            }
        }
    }
}
