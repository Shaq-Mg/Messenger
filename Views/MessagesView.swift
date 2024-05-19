//
//  MessagesView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 19/05/2024.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                MessagesDisplayBar()
                ScrollView {
                    ForEach(0..<8) { item in
                        HStack {
                            Circle()
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Email")
                                    .font(.system(size: 18, weight: .semibold))
                                Text("Message")
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("Time")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Divider()
                            .padding(.vertical, 6)
                    }
                }
            }
//            .overlay(
//                Button(action: {
//
//                }, label: {
//                    Image(systemName: "plus")
//                        .font(.system(size: 24, weight: .bold))
//                        .padding(6)
//                        .background(Circle().stroke(lineWidth: 3))
//                        .foregroundStyle(.mint)
//                }),
//                alignment: .bottom)
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MessagesView()
        }
    }
}

struct MessagesDisplayBar: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 50, height: 50)
            Text("USER")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            NavigationLink {
                
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
            }
        }
        .padding(.vertical)
    }
}
