//
//  ChatMessageRow.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import SwiftUI

struct ChatMessageRow: View {
    @State private var showTime = false
    let manager = FirebaseManger.shared
    let message: Message
    var body: some View {
        VStack {
            if message.fromId == manager.auth.currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundStyle(.black)
                    }
                    .onTapGesture {
                        showTime.toggle()
                    }
                    .padding()
                    .background(.mint.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    if showTime {
                        Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading)
                    }
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundStyle(.black)
                    }
                    .onTapGesture {
                        showTime.toggle()
                    }
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    if showTime {
                        Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct ChatMessageRow_Previews: PreviewProvider {
    static var previews: some View {
        var data = [FirebaseConstants.fromId: "fromId", FirebaseConstants.toId: "toId", FirebaseConstants.text: "Good morning, world!", FirebaseConstants.timestamp: Date()] as [String : Any]
        ChatMessageRow(message: Message(data: data))
    }
}
