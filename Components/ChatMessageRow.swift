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
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? .gray.opacity(0.2) : .mint.opacity(0.2))
                    .cornerRadius(20)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(message.received ? .leading : .trailing)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
    }
}

struct ChatMessageRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageRow(message: Message(id: "1234", text: "Good morning, world!", received: false, timestamp: Date()))
    }
}
