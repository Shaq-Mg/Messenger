//
//  NewMessageView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 23/05/2024.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<8) { num in
                    Text("New meassage")
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
