//
//  LoginView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 07/12/2024.
//

import SwiftUI
import PhotosUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(spacing: 14) {
            
            InputView(text: $authViewModel.email, placeholder: "Email")
            InputView(text: $authViewModel.password, placeholder: "Password", isSecureField: true)
            
            Text(authViewModel.errorMessage)
                .foregroundStyle(.red)
                .padding()
            
            Button("Sign In") {
                authViewModel.signIn()
            }
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.mint)
            .cornerRadius(8)
            .padding(.vertical)
            
            NavigationLink {
                CreateAccountView()
                    .environmentObject(authViewModel)
            } label: {
                Text("Dont have a existing accont?")
                Text("Sign up").bold()
            }
            .foregroundStyle(.black)

            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden(true)
        .onAppear { authViewModel.clearLoginInformation() }
        
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}

