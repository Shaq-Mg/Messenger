//
//  ShowMenuButtonView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI

struct ShowMenuButtonView: View {
    @Binding var isMenuShowing: Bool
    var body: some View {
        HStack {
            Button {
                isMenuShowing.toggle()
            } label: {
                Image(systemName: "line.3.horizontal")
                    .imageScale(.small)
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .padding(10)
                    .background(Circle().foregroundStyle(.white))
                    .shadow(radius: 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    ShowMenuButtonView(isMenuShowing: .constant(false))
}
