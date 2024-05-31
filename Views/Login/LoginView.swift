//
//  LoginView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    let didCompleteLoginProcess: () -> ()
    
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
                        signIn()
                        if formIsValid {
                            withAnimation(.easeOut(duration: 1.0)) {
                                viewModel.email = ""
                                viewModel.password = ""
                            }
                        }
                    } label: {
                        Text("Sign In")
                            .font(.system(size: 20).bold())
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    NavigationLink("Dont have a account? Sign up") {
                        SignUpView()
                    }
                    .font(.callout)
                    .foregroundStyle(.black)
                    Text(viewModel.loginStatusMessage)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden(true)
    }
   private func signIn() {
       viewModel.manager.auth.signIn(withEmail: viewModel.email, password: viewModel.password) { result, error in
            if let error = error {
                print("Failed to sign in user:", error)
                viewModel.loginStatusMessage = "Failed to sign in user: \(error)"
                return
            }
            print("Successfully signed in as user: \(result?.user.uid ?? "")")
           viewModel.loginStatusMessage = "Successfully signed in as user: \(result?.user.uid ?? "")"
           self.didCompleteLoginProcess()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView(didCompleteLoginProcess: { })
                .environmentObject(AuthenticationViewModel())
        }
    }
}
extension LoginView: AuthFormProtocol {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 4
    }
}
