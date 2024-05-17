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
                       
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
            .font(.system(size: 20))
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 2)
            .textFieldStyle(.roundedBorder)
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Preview", placeholder: "Preview")
    }
}
