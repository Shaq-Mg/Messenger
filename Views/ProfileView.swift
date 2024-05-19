//
//  ProfileView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 19/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var vm: LoginService
    
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
                    Text("email")
                        .font(.headline)
                }
            }
            ProfileHeader()
            
            AccountInfoSection()
            Button {
                vm.showSignOutAlert.toggle()
            } label: {
                Text("Sign Out")
                    .font(.headline)
            }
            Button {
                
            } label: {
                Text("Delete Acount")
                    .foregroundStyle(.red)
                    .font(.headline)
            }
        }
        .navigationTitle("My Account")
        .navigationBarItems(trailing: Button(action: {
            vm.isLoggedOut.toggle()
        }, label: {
            Text("Sign out").bold()
        }))
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
            .environmentObject(LoginService())
    }
}

struct ProfileHeader: View {
    @EnvironmentObject var vm: LoginService
    var body: some View {
        if let user = vm.user {
            HStack(spacing: 14){
                Text("Photo")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 70, height: 70)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(vm.username)
                        .font(.headline)
                    
                    Text("@\(vm.username)")
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

struct AccountInfoSection: View {
    @EnvironmentObject var vm: LoginService
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
