//
//  LoginView.swift
//  Foody
//
//  Created by An Nguyễn on 2/24/21.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
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
                    
                    TextFieldCustom(text: $viewModel.password,
                                    placeholder: Text("Password").foregroundColor(.gray),
                                    onCommit: {
                                        // TODO:
                                    }, isSecureField: true)

                }
                .regular(size: 18)
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 70, trailing: 20))
                
                VStack(spacing: 15) {
                    Button(action: {}, label: {
                        Text("Sign In")
                            .bold(size: 18)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(0.7))
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    
                    Button(action: {
                        
                    }, label: {
                        Text("Forgot password?")
                    })
                }
                .regular(size: 15)
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        
                    }, label: {
                        Text("Create one")
                            .bold()
                    })
                }
                .frame(maxWidth: .infinity)
                .padding([.bottom, .horizontal], 15)
                .regular(size: 15)
            }
        }
        .navigationBarHidden(true)
        .foregroundColor(.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
