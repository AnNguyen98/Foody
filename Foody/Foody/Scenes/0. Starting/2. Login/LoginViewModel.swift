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
    
    var subscriptions = Set<AnyCancellable>()
    
    func login() {
        isLoading = true
//        HomeService().getPupularMovies()
//            .sink(receiveCompletion: { completion in
//                guard case let .failure(error) = completion else { return }
//                self.isLoading = false
//                print("AAAA", error)
//            }, receiveValue: { response in
//                print("AAAA", response)
//                self.isLoading = false
//            }).store(in: &subscriptions)
        
        LoginService.login(email: self.email, password: self.password)
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.error = error as? NetworkError
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
