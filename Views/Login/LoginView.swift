//
//  LoginView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        
                        InputView(text: $viewModel.email, title: "Email", placeholder: "Test@hotmail.com")
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", isSecureField: true)
                    }
                    Button {
                        
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                    }
                    .buttonStyle(.bordered)
                    
                    NavigationLink("Dont have a account? Sign up") {
                        SignUpView()
                    }
                    .font(.callout)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Sign In")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView()
                .environmentObject(LoginViewModel())
        }
    }
}
