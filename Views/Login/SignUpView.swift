//
//  SignUpView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mint.ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        
                        InputView(text: $viewModel.email, title: "Email", placeholder: "Test@hotmail.com")
                        
                        InputView(text: $viewModel.username, title: "Username", placeholder: "Test123")
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", isSecureField: true)
                        
                        InputView(text: $viewModel.confirmPassword, title: "Confirm Passowrd", placeholder: "Confirm password", isSecureField: true)
                    }
                    Button {

                    } label: {
                        Text("Sign Up")
                            .font(.headline)
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Already have a existing account? Sign In") {
                        dismiss()
                    }
                    .font(.callout)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Create Account")
        .navigationBarBackButtonHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView()
                .environmentObject(LoginViewModel())
        }
    }
}
