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
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Verify your Phone number")
                        .bold(size: 34)
                    Text("Enter your OTP code here.")
                        .regular(size: 18)
                        .padding(.vertical, 15)
                                        
                    ZStack {
                        HStack(spacing: 10) {
                            ForEach(0..<viewModel.lengthLimit) { i in
                                let text = viewModel.codeNumberOf(index: i)
                                VStack(spacing: 0) {
                                    Text("\(text)")
                                        .bold(size: 40)
                                        .frame(height: 60)
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(height: 4)
                                        .foregroundColor(text != viewModel.codeTextEmpty ? Color.green: Color.gray)
                                        .opacity(0.5)
                                }
                            }
                        }
                        
                        TextField("", text: $viewModel.code)
                            .frame(height: 70)
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .foregroundColor(.clear)
                            .opacity(0.015)
                            
                    }
                    .padding(.top, 40)
                                        
                    Button(action: {
                        viewModel.handleAction()
                    }, label: {
                        Text("Verify Now")
                            .bold(size: 18)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(viewModel.isValid ? 1: 0.3))
                            .foregroundColor(.white)
                    })
                    .disabled(!viewModel.isValid)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.vertical, 40)
                }
                .padding(.top, Constants.MARGIN_WITH_BACK_BAR)
                .padding(.horizontal)
            }
            .addBackBarCustom(.black)
            .onAppear(perform: {
                UIScrollView.appearance().bounces = false
            })
        }
        .handleHidenKeyboard()
        .statusBarStyle(.darkContent)
        .foregroundColor(Color.black)
    }
}

struct VerifyPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VerifyPhoneView()
        }
    }
}
