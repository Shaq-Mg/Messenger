//
//  MessageField.swift
//  Messenger
//
//  Created by Shaquille McGregor on 24/05/2024.
//

import SwiftUI

struct MessageField: View {
    @ObservedObject var vm: ChatMessageViewModel
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: 20))
            }
            
            HStack {
                CustomTextField(placeholder: Text("Description"), text: $vm.chatText)
                
                Button {
                    vm.sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.mint.opacity(0.6))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
        }
        .padding(.leading, 10)
    }
}

//struct MessageField_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageField()
//    }
//}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty  {
                placeholder
                    .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
