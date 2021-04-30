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
    var phoneNumber: String = ""
    
    var invalidInfo: Bool {
        !(email.isValidateEmail && newPassword.isValidPasswordLength
            && confirmPassword.isValidPasswordLength && newPassword == confirmPassword)
    }
    
    var verifyPhoneViewModel: VerifyPhoneViewModel {
        VerifyPhoneViewModel(for: .updatePassword(phoneNumber))
    }
    
    func handleCheckEmail() {
        isLoading = true
        AccountService.verifyEmail(email: email)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                if let phoneNumber = res.phoneNumber {
                    if phoneNumber.validatePhoneNumber {
                        self.phoneNumber = phoneNumber
                        self.emailExist = res.isValid ?? false
                    } else {
                        self.error = .unknow("Phone number is invalid.")
                    }
                }
            }
            .store(in: &subscriptions)
    }
}
