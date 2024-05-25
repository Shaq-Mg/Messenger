//
//  ChatMessageView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import SwiftUI

struct ChatMessageView: View {
    @ObservedObject var vm: ChatMessageViewModel
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    var body: some View {
        VStack {
            VStack {
                titleRow
                ScrollView {
                    ScrollViewReader { ScrollViewProxy in
                        ForEach(vm.messages) { message in
                            ChatMessageRow(message: message)
                        }
                        HStack { Spacer() }
                            .id(vm.scrollToId)
                            .onReceive(vm.$messageCount) { _ in
                                withAnimation(.easeOut(duration: 0.5)) {
                                    ScrollViewProxy.scrollTo("Empty", anchor: .bottom)
                                }
                            }
                    }
                }
            }
            MessageField(chatUser: chatUser)
        }
    }
    
    private var titleRow: some View {
        HStack(spacing: 20) {
            Circle()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 6) {
                Text(vm.chatUser?.username ?? "user")
                    .font(.system(size: 20, weight: .semibold))
                Text(vm.chatUser?.email ?? "")
                    .foregroundStyle(.secondary)
                    .font(.caption2)
            }
            
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "phone.fill")
                    .font(.system(size: 20))
                    .padding(8)
                    .background(.white)
                    .clipShape(Circle())
                
            }
        }
        .padding()
        .background(.mint.opacity(0.2))
    }
}

//struct ChatMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatMessageView()
//    }
//}
