//
//  ModifierExt.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI
import Combine

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
            .padding(.top, 15)
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


// Keyboard
struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                .map { $0.cgRectValue.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
       ).eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
    }
}

extension View {
    func keyboardAwarePadding() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    }
}
