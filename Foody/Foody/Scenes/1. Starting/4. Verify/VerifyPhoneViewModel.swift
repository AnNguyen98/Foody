//
//  VerifyPhoneViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import SwiftUI

final class VerifyPhoneViewModel: ViewModel, ObservableObject {
    private var user = RegisterUserObject()
    var action: Action
    
    init(for action: Action = .updatePassword) {
        if case .register(let user) = action {
            self.user = user
        }
        self.action = action
    }
    
    @Published var code: String = "" {
        didSet {
            if /*Int(code) == nil || */ code.count > lengthLimit {
                code = oldValue
            }
            
            // Dismiss keyboard
            if code.count == lengthLimit {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    func codeNumberOf(index: Int) -> String {
        values[safeIndex: index] ?? codeTextEmpty
    }
}

extension VerifyPhoneViewModel {
    private func handleUpdatePassword() {
        
    }
    
    private func handleRegister() {
        
    }
    
    func handleAction() {
        if case .register = action {
            handleRegister()
        } else {
            handleUpdatePassword()
        }
    }
}

extension VerifyPhoneViewModel {
    enum Action {
        case register(RegisterUserObject), updatePassword
    }
    
    var lengthLimit: Int { 6 }
    
    var values: [String] {
        Array(code)
            .map({ String($0) })
    }
    
    var isValid: Bool {
        code.count >= lengthLimit
    }
    
    var codeTextEmpty: String {
        "∙"
    }
}



