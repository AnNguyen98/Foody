//
//  LoginViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/18/21.
//

import SwiftUI
import Combine
import Moya

final class LoginViewModel: ViewModel, ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: NetworkError?
    @Published var isLogged: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    override init() {
        super.init()
        Session.shared.isShowedOnboarding = true
    }
    
    func login(completion: (() -> Void)? = nil) {
        guard !invalidInfo else {
            return
        }
        isLoading = true
        AccountService.login(email: self.email, password: self.password)
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.error = error
                } else {
                    self.isLogged = true
                }
                self.isLoading = false
            } receiveValue: { (response) in
                print("LoginService", response.email, response.token)
            }
            .store(in: &subscriptions)
    }
}

extension LoginViewModel {
    
    var invalidInfo: Bool {
        !(email.isValidateEmail && password.isValidPasswordLength)
    }
}
