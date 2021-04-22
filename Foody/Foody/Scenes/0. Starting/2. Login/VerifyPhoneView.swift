//
//  VerifyPhoneView.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import SwiftUI
import Foundation

struct VerifyPhoneView: View {
    @StateObject var viewModel = VerifyPhoneViewModel()
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("Verify your Phone number")
                .bold(size: 34)
            Text("Enter your OTP code here")
                .regular(size: 17)
                .padding(.top, 5)
            
            Spacer()
            
            ZStack {
                HStack(spacing: 10) {
                    ForEach(0..<6) { i in
                        let text = String(viewModel.values[safeIndex: i] ?? "*")
                        VStack(spacing: 0) {
                            Text("\(text)")
                                .bold(size: 36)
                            RoundedRectangle(cornerRadius: 2)
                                .frame(height: 4)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                    }
                }
                
                TextField("", text: $viewModel.code)
                    .frame(height: 60)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .foregroundColor(.clear)
                    .opacity(0.015)
                    
            }
            .padding(.top, 40)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("Verify Now")
                    .bold(size: 18)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(viewModel.isValid ? 1: 0.3))
                    .foregroundColor(.white)
            })
            .disabled(!viewModel.isValid)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom, 60)
            
            Spacer()
        }
        .padding(.horizontal)
        .statusBarStyle(.darkContent)
    }
}

struct VerifyPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VerifyPhoneView()
        }
    }
}
