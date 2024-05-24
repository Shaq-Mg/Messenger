//
//  ChatMessageView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import SwiftUI

struct ChatMessageView: View {
    let chatUser: ChatUser?
    
    var body: some View {
        VStack {
            VStack {
                titleRow
                ScrollView {
                    
                }
            }
            MessageField()
        }
    }
    
    private var titleRow: some View {
        HStack(spacing: 20) {
            Circle()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(chatUser?.username ?? "user")
                    .font(.system(size: 20, weight: .semibold))
                Text(chatUser?.email ?? "")
                    .foregroundStyle(.secondary)
                    .font(.callout)
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
        .background(.mint.opacity(0.6))
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        let data: [String: Any] = ["email": String(), "username": String()]
        ChatMessageView(chatUser: ChatUser(data: data))
    }
}
