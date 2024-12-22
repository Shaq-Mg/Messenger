//
//  MainMessagesView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI

struct MainMessagesView: View {
    @EnvironmentObject var mainMessagesVM: MainMessagesViewModel
    @State private var user: User?
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        VStack {
            mainMessagesHeader
            messagesScrollView
            
        }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .bottomTrailing) {
            Button("+ New message") {
                mainMessagesVM.showNewMessageScreen.toggle()
                isMenuShowing = false
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.mint)
            .padding()
            .fullScreenCover(isPresented: $mainMessagesVM.showNewMessageScreen) {
                NewMessageView(didSelectNewUser: { user in
                    print(user.email)
                    self.user = user
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainMessagesView(isMenuShowing: .constant(false))
            .environmentObject(MainMessagesViewModel())
    }
}
extension MainMessagesView {
    
    private var mainMessagesHeader: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: URL(string: mainMessagesVM.user?.profileImageUrl ?? "")) { image in
                image
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                    .overlay(Circle().stroke(Color(.label), lineWidth: 2))
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                let email = mainMessagesVM.user?.email.replacingOccurrences(of: "@gmail.com", with: "")
                Text(email ?? "email")
                    .font(.system(size: 20, weight: .bold))
            }
            Spacer()
            
            ShowMenuButtonView(isMenuShowing: $isMenuShowing)
        }
        .padding(8)
        .padding(.leading)
        .background(.thickMaterial)
    }
    
    private var messagesScrollView: some View {
        ScrollView {
            ForEach(mainMessagesVM.recentMessages) { recentMessage in
                VStack {
                    NavigationLink {
                        ChatView(user: user)
                    } label: {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: mainMessagesVM.user?.profileImageUrl ?? "")) { image in
                                image
                                    .scaledToFill()
                                    .frame(width: 34, height: 34)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                                    .overlay(Circle().stroke(Color(.label), lineWidth: 2))
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.email)
                                    .font(.system(size: 16, weight: .semibold))
                                
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color(.systemGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Text(recentMessage.timestamp.description)
                                .font(.system(size: 10))
                                .foregroundStyle(.secondary)
                        }
                        .foregroundStyle(Color(.label))
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
        }
    }
}
