//
//  NewMessageView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 23/05/2024.
//

import SwiftUI

struct NewMessageView: View {
    @ObservedObject var vm = NewMessageViewModel()
    let didSelectNewUser: (ChatUser) -> ()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(vm.users) { user in
                        HStack(spacing: 20) {
                            ProgressView()
                            NavigationLink {
                                ChatMessageView(chatUser: user)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.username)
                                        .foregroundStyle(Color(.label))
                                        .font(.headline)
                                    Text(user.email)
                                        .font(.caption)
                                }
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.callout).bold()
                                .foregroundStyle(.mint)
                        }
                        .foregroundStyle(.secondary)
                        Divider()
                    }
                }
                .padding(.horizontal)
            }.navigationTitle("New Message")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .font(.headline)
                        }
                        
                    }
                }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(didSelectNewUser: { _ in })
    }
}
