//
//  NewMessageView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 23/05/2024.
//

import SwiftUI

struct NewMessageView: View {
    @ObservedObject var vm = NewMessageViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vm.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.username)
                            .font(.headline)
                        Text(user.email)
                            .foregroundStyle(.secondary)
                    }
                }
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
        NewMessageView()
    }
}
