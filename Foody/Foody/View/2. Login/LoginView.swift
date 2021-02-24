//
//  LoginView.swift
//  Foody
//
//  Created by An Nguyễn on 2/24/21.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("bg_login")
                .resizable()
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back")
                            .font(.system(size: 44))
                        Text("Sign in to continue")
                            .font(.system(size: 17))
                    }
                    .padding(.horizontal)
                    .padding(.top, 60)
                    
                    VStack(spacing: 20) {
                        TextFieldCustom(text: $username,
                                        placeholder: Text("Username").foregroundColor(.gray))
                        
                        TextFieldCustom(text: $password,
                                        placeholder: Text("Password").foregroundColor(.gray),
                                        onCommit: {}, isSecureField: true)

                    }
                    .font(.system(size: 17))
                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 60, trailing: 20))
                    
                    VStack(spacing: 20) {
                        Button(action: {}, label: {
                            Text("Sign In")
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)))
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Button(action: {}, label: {
                            HStack {
                                Image("facebook_icon")
                                    .resizable()
                                    .frame(width: 12, height: 24)
                                Text("Connect with Facebook")
                            }
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(#colorLiteral(red: 0.1490196078, green: 0.4470588235, blue: 0.7960784314, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        })
                        
                        Button(action: {}, label: {
                            Text("Forgot password?")
                        })
                        
                        Spacer()
                        
                        HStack {
                            Text("Don't have an account?")
                            Button(action: {}, label: {
                                Text("Sign up")
                                    .bold()
                            })
                        }
                        .padding(.bottom, 15)
                    }
                    .font(.system(size: 15))
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
        .foregroundColor(.white)
        .onAppear(perform: {
//            UIApplication.shared.statusBarStyle = .lightContent
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
