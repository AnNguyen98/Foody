//
//  LoginView.swift
//  Foody
//
//  Created by An Nguyễn on 2/24/21.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Image("bg_login")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Welcome back")
                        .bold(size: 44)
                    Text("Sign in to continue")
                        .regular(size: 18)
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                VStack(spacing: 30) {
                    TextFieldCustom(text: $viewModel.email,
                                    placeholder: Text("Email").foregroundColor(.gray))
                        .frame(minHeight: 50)
                    
                    TextFieldCustom(text: $viewModel.password,
                                    placeholder: Text("Password").foregroundColor(.gray),
                                    onCommit: {
                                        handleLogin()
                                    }, isSecureField: true)
                        .frame(minHeight: 50)

                }
                .regular(size: 18)
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 70, trailing: 20))
                
                VStack(spacing: 15) {
                    Button(action: {
                        handleLogin()
                    }, label: {
                        Text("Sign In")
                            .bold(size: 18)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundColor(Color.white.opacity(viewModel.invalidInfo ? 0.5: 1))
                            .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(viewModel.invalidInfo ? 0.5: 0.7))
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .disabled(viewModel.invalidInfo)
                    
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot password?")
                    }
                }
                .regular(size: 15)
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: RegisterView()) {
                        Text("Create one")
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding([.bottom, .horizontal], 15)
                .regular(size: 15)
            }
            
            if viewModel.isLoading {
                IndefiniteProgressView()
                    .animation(.easeInOut)
            }
        }
        .navigationBarHidden(true)
        .statusBarStyle(.lightContent)
        .foregroundColor(.white)
        .disabled(viewModel.isLoading)
        .handleHidenKeyboard()
        .handleAction(isActive: $viewModel.isLogged, action: {
            SceneDelegate.shared.makeRoot(.logged)
        })
    }
}

//MARK: - API
extension LoginView {
    private func handleLogin() {
        hideKeyboard()
        viewModel.login()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
