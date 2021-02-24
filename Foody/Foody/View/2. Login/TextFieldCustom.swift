//
//  TextFieldCustom.swift
//  Foody
//
//  Created by An Nguyễn on 2/24/21.
//

import SwiftUI

struct TextFieldCustom: View {
    @Binding var text: String
    var placeholder: Text
    var onCommit: (() -> Void)?
    var isSecureField: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty { placeholder }
                HStack {
                    if isSecureField {
                        SecureField("", text: $text, onCommit: {
                            onCommit?()
                        })
                    } else {
                        TextField("", text: $text, onCommit: {
                            onCommit?()
                        })
                    }
                    if !text.isEmpty {
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                        })
                    }
                }
            }
            .padding(.horizontal, 10)
            
            Divider()
                .background(Color.white)

        }
    }
}
