//
//  ForgotPasswordViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI

final class ForgotPasswordViewModel: ViewModel, ObservableObject {
    @Published var email: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var emailExist: Bool = false
    
    var invalidInfo: Bool {
        !(email.isValidateEmail && newPassword.isValidPasswordLength
            && confirmPassword.isValidPasswordLength && newPassword == confirmPassword)
    }
    
    func handleCheckEmail() {
        
    }
    
    func handleUpdatePassword() {
        
    }
}
