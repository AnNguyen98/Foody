//
//  RegisterView.swift
//  Foody
//
//  Created by An Nguyễn on 2/28/21.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @State var isRestaurantJoined: Bool = false
    
    var body: some View {
        ZStack {
            Image("bg_login")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.top, 30)
                    
                    Text("JOIN US")
                        .bold(size: 44)
                    
                    Toggle("Join with restaurant:", isOn: $isRestaurantJoined)
                        .bold(size: 17)
                    
                    VStack(spacing: 20) {
                        TextFieldCustom(text: $viewModel.username,
                                        placeholder: Text("Username").foregroundColor(.gray),
                                        systemNameImage: "person"
                        )
                        
                        if isRestaurantJoined {
                            TextFieldCustom(text: $viewModel.restaurantName,
                                            placeholder: Text("Restaurant name").foregroundColor(.gray),
                                            systemNameImage: "person"
                            )
                        }
                        
                        TextFieldCustom(text: $viewModel.email,
                                        placeholder: Text("Email").foregroundColor(.gray)
                        )
                        
                        TextFieldCustom(text: $viewModel.phoneNumber,
                                        placeholder: Text("+84").foregroundColor(.gray),
                                        systemNameImage: "phone.fill"
                        )
                        .keyboardType(.numberPad)
                        
                        TextFieldCustom(text: $viewModel.password,
                                        placeholder: Text("Password").foregroundColor(.gray),
                                        isSecureField: true
                        )
                        
                        TextFieldCustom(text: $viewModel.verifyPassword,
                                        placeholder: Text("Confirm password").foregroundColor(.gray),
                                        isSecureField: true
                        )
                        
                        Button(action: {}, label: {
                            Text("Sign Up")
                                .bold(size: 18)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(0.7))
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.vertical, 30)
                    }
                    .animation(.default)
                }
                .foregroundColor(.white)
                .padding(.horizontal)
            }
        }
        .addBackBarCustom()
        .statusBarStyle(.lightContent)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
        }
    }
}
