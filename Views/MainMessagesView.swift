//
//  MessagesView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 19/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainMessagesView: View {
    @ObservedObject var vm = MainMessagesViewModel()
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
            ForEach(vm.recentMessages) { recentMessage in
                NavigationLink {
                    ChatMessageView(chatUser: vm.chatUser)
                } label: {
                    HStack {
                        Circle()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recentMessage.username)
                                .font(.system(size: 18, weight: .semibold))
                            Text(recentMessage.text)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Text(recentMessage.timestamp.description)
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

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainMessagesView()
        }
    }
}

struct MessagesDisplayBar: View {
    @ObservedObject var vm: MainMessagesViewModel
    var body: some View {
        HStack {
            WebImage(url: URL(string: vm.chatUser?.photoImageUrl ?? ""))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .frame(width: 5, height: 50)
            .shadow(radius: 5)
            
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
