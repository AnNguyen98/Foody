//
//  ForgotPasswordView.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Forgot password ")
                    .bold(size: 34)
                    .padding(.top, 15)
                
                Text("Enter your email address below and we'll send you an email with instructions on how to change your password")
                    .regular(size: 17)
                
                TextFieldCustom(text: $viewModel.email,
                                placeholder: Text("Enter your email").foregroundColor(.gray))
                    .padding(.vertical, 40)
                
                Button(action: {
                    
                }, label: {
                    Text("Continue...")
                        .bold(size: 18)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(0.7))
                })
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.vertical, 30)
                .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .addBackBarCustom(.black)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ForgotPasswordView()
        }
    }
}
