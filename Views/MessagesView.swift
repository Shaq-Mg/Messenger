//
//  MessagesView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 19/05/2024.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var vm = MessagesViewModel()
    @State private var showNewMessageScreen = false
    var body: some View {
        NavigationStack {
            VStack {
                MessagesDisplayBar(vm: vm)
                messageListView
                
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal)
            .fullScreenCover(isPresented: $showNewMessageScreen, content: {
                NewMessageView(didSelectNewUser: { user in
                    vm.navigateToChatMessageView.toggle()
                    vm.chatUser = user
                    print(user.email)
                })
            })
            .fullScreenCover(isPresented: $vm.isLoggedOut, onDismiss: nil) {
                LoginView(didCompleteLoginProcess: {
                    vm.isLoggedOut = false
                    vm.fetchCurrentUser()
                })
                .environmentObject(AuthenticationViewModel())
            }
            .overlay(
                Button(action: {
                    showNewMessageScreen.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .padding(6)
                        .background(Circle().stroke(lineWidth: 3))
                        .foregroundStyle(.mint)
                }),
                alignment: .bottom)
        }
    }
    private var messageListView: some View {
        ScrollView {
            ForEach(0..<8) { item in
                NavigationLink {
                    ChatMessageView(chatUser: vm.chatUser)
                } label: {
                    HStack {
                        Circle()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(vm.chatUser?.username ?? "")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Message")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("Time")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Divider()
                        .padding(.vertical, 6)
                }

            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MessagesView()
        }
    }
}

struct MessagesDisplayBar: View {
    @ObservedObject var vm: MessagesViewModel
    var body: some View {
        HStack {
            Circle()
                .frame(width: 50, height: 50)
            Text(vm.chatUser?.username ?? "user")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            NavigationLink {
                ProfileView()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
            }
        }
        .padding(.vertical)
    }
}
