//
//  LoginView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct LoginView: View {
    let didCompleteLoginProcess: () -> ()
    @EnvironmentObject var viewModel: LoginService
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mint.ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        
                        InputView(text: $viewModel.email, title: "Email", placeholder: "Test@hotmail.com")
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", isSecureField: true)
                    }
                    Button {
                        viewModel.signIn(email: viewModel.email, password: viewModel.password)
                        didCompleteLoginProcess()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            dismiss()
                        }
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                    }
                    .buttonStyle(.bordered)
                    
                    NavigationLink("Dont have a account? Sign up") {
                        SignUpView()
                    }
                    .font(.callout)
                    
                    Text(viewModel.loginStatusMessage)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView(didCompleteLoginProcess: { })
                .environmentObject(LoginService())
        }
    }
}
