//
//  SignUpView.swift
//  Messenger
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mint.ignoresSafeArea()
                VStack(spacing: 20) {
                    PhotosPicker(selection: $viewModel.selectedImage) {
                        if let data = viewModel.data, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.white)
                                .padding()
                                .overlay(Circle().stroke(lineWidth: 2).foregroundStyle(.white))
                        }
                    }
                    .frame(width: 80, height: 80)
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
                .onChange(of: viewModel.selectedImage, perform: { newValue in
                    guard let item = viewModel.selectedImage else { return }
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                viewModel.data = data
                            }
                        case .failure(_):
                            print("Failed to convert data into image")
                        }
                    }
                })
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
