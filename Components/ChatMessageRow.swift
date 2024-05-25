//
//  ChatMessageRow.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import SwiftUI

struct ChatMessageRow: View {
    @State private var showTime = false
    let message: Message
    var body: some View {
        if message.fromId == FirebaseManger.shared.auth.currentUser?.uid {
            VStack(alignment: .leading) {
                HStack {
                    Text(message.text)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 300, alignment: .leading)
                .onTapGesture {
                    showTime.toggle()
                }
                if showTime {
                    Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
        } else {
            VStack(alignment: .trailing) {
                HStack {
                    Text(message.text)
                        .padding()
                        .background(.mint.opacity(0.2))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 300, alignment: .trailing)
                .onTapGesture {
                    showTime.toggle()
                }
                if showTime {
                    Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
        }
    }
}

struct ChatMessageRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageRow(message: Message(fromId: "", toId: "", username: "Saka", email: "saka@gmail.com", text: "Good morning, world!", timestamp: Date()))
    }
}
