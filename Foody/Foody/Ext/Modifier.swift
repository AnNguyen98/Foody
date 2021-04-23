//
//  ModifierExt.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI

struct BackBarModifier: ViewModifier {
    var action: (()-> Void)?
    var color: Color
    var navigationBarHidden: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            HStack {
                BackButton(action: action)
                    .foregroundColor(color)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .navigationBarHidden(navigationBarHidden)
    }
}

extension View {
    func addBackBarCustom(_ color: Color = .white, barHidden: Bool = true,
                          action: (()-> Void)? = nil) -> some View {
        self.modifier(BackBarModifier(action: action, color: color, navigationBarHidden: barHidden))
    }
}


struct HandleKeyboardModifier: ViewModifier {
    var hiddenAction: () -> Void
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .onTapGesture {
                    hiddenAction()
                }
        }
    }
}

extension View {
    func handleHidenKeyboard() -> some View {
        self.modifier(
            HandleKeyboardModifier(hiddenAction: {
                hideKeyboard()
            })
        )
    }
}
