//
//  ButtonCircleBackground.swift
//  Foody
//
//  Created by An Nguyễn on 28/04/2021.
//

import SwiftUI

struct ProfileButtonView: View {
    var action: (() -> Void)?
    var text: String
    var imageName: String
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Label(
                title: {
                    Text(text)
                        .padding(.leading, 40)
                        .systemBold(size: 19)
                    
                    Spacer()
                },
                icon: {
                    Image(imageName)
                        .resizable()
                        .frame(.init(width: 23, height: 24))
                        .background(
                            Circle()
                                .frame(.init(width: 50, height: 50))
                                .foregroundColor(Color(#colorLiteral(red: 0.1568627451, green: 0.1764705882, blue: 0.2117647059, alpha: 1)))
                        )
                }
            )
        }
        .padding([.top], 20)
        .padding(.horizontal)
    }
}
