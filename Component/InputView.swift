//
//  InputView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(.secondary)
                .font(.footnote)
            
            VStack {
                if isSecureField {
                    TextField(placeholder, text: $text)
                        .frame(maxWidth: .infinity)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Preview", placeholder: "Preview")
    }
}
