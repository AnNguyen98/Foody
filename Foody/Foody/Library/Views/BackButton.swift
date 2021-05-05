//
//  BackButton.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.presentationMode) private var presentationMode
    private var action: (() -> Void)?
    
    init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action?()
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
        })
        .font(.system(size: 18, weight: .bold, design: .default))
    }
}
