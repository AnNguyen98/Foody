//
//  RegisterView.swift
//  Foody
//
//  Created by An Nguyễn on 2/28/21.
//

import SwiftUI
import SwiftUIX

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            Image("bg_login")
                .resizable()
                .ignoresSafeArea()
            
            NavigationLink(destination: VerifyPhoneView(viewModel: viewModel.verifyPhoneViewModel),
                           isActive: $viewModel.emailNotExist, label: { EmptyView() })
            
            ScrollView {
                VStack(alignment: .leading) {
                    Section {
                        Text("Register")
                            .bold(size: 44)
                        Text("Please enter details to register.")
                            .regular(size: 18)
                            .padding(.bottom, 30)
                    }
                    
                    Section(header: Text("")) {
                        Toggle("Join with restaurant:", isOn: $viewModel.isRestaurant)
                            .bold(size: 17)
                    }
                    
                    Section(header: Text(""), footer: Text("")) {
                        TextFieldCustom(text: $viewModel.userInfo.username,
                                        placeholder: Text("Username").foregroundColor(.gray),
                                        systemNameImage: "person"
                        )
                        
                        if viewModel.isRestaurant {
                            TextFieldCustom(text: $viewModel.userInfo.restaurantName,
                                            placeholder: Text("Restaurant name").foregroundColor(.gray),
                                            systemNameImage: "house"
                            )
                            
                            TextView("Descriptions...", text: $viewModel.userInfo.description)
                                .frame(minHeight: 100, maxHeight: 150)
                                .padding(.vertical)
                        }
                    }
                    
                    Section(header: Text(""), footer: Text("")) {
                        HStack(spacing: 10) {
                            Text("Gender")
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .padding(.trailing, 5)
                            
                            Spacer()
                            
                            RadioButton(isSelected: $viewModel.isMale,
                                        action: {
                                            viewModel.isMale = true
                            }, content: { Text("Female") })
                            
                            RadioButton(isSelected: .constant(!viewModel.isMale),
                                        action: {
                                            viewModel.isMale = false
                            }, content: { Text("Male") })
                                .padding(.trailing, 10)
                            }
                    }
                    .animation(.easeInOut(duration: 0.3))
                    
                    Section(header: Text(""), footer: Text("")) {
                        TextFieldCustom(text: $viewModel.userInfo.email,
                                        placeholder: Text("Email").foregroundColor(.gray)
                        )
                        
                        TextFieldCustom(text: $viewModel.userInfo.phoneNumber,
                                        placeholder: Text("+84").foregroundColor(.gray),
                                        systemNameImage: "phone.fill"
                        )
                        .keyboardType(.numberPad)
                    }
                    
                    
                    Section(header: Text(""), footer: Text("")) {
                        TextFieldCustom(text: $viewModel.userInfo.password,
                                        placeholder: Text("Password").foregroundColor(.gray),
                                        isSecureField: true
                        )
                        
                        TextFieldCustom(text: $viewModel.userInfo.verifyPassword,
                                        placeholder: Text("Confirm password").foregroundColor(.gray),
                                        isSecureField: true
                        )
                    }
                    
                    Section(header: Text(""), footer: Text("")) {
                        Button(action: {
                            viewModel.checkEmail()
                        }, label: {
                            Text("Register")
                                .bold(size: 18)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(0.7))
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.top, 30)
                    }
                    
                    Section(header: Text(""), footer: Text("")) {
                        HStack {
                            Text("Already have an account?")
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Login")
                                    .underline()
                                    .bold(size: 17)
                            })
                        }
                        .padding(.top, Constants.MARGIN_WITH_BACK_BAR)
                        .frame(maxWidth: .infinity)
                    }
                }
                .animation(.default)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.top, Constants.MARGIN_WITH_BACK_BAR)
            }
            .addBackBarCustom()
            .padding(.top, Constants.MARGIN_TOP_STATUS_BAR)
        }
        .handleHidenKeyboard()
        .statusBarStyle(.lightContent)
        .regular(size: 17)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
        }
    }
}
