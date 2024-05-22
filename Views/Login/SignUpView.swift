//
//  SignUpView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
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
                        viewModel.createAccount()
                        if formIsValid {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.easeOut(duration: 1.0)) {
                                    viewModel.username = ""
                                    viewModel.email = ""
                                    viewModel.password = ""
                                    viewModel.confirmPassword = ""
                                    dismiss()
                                }
                            }
                        }
                    } label: {
                        Text("Sign Up")
                            .font(.headline)
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Already have a existing account? Sign In") {
                        dismiss()
                    }
                    .font(.callout)
                    
                    Text(viewModel.loginStatusMessage)
                        .foregroundStyle(.secondary)
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
                .environmentObject(AuthenticationViewModel())
        }
    }
}
extension SignUpView {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.username.isEmpty
        && viewModel.username.count > 3
        && !viewModel.password.isEmpty
        && viewModel.password.count > 4
        && viewModel.confirmPassword == viewModel.password
    }
}
