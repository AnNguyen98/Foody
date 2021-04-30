//
//  ViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import Combine

class ViewModel {
    lazy var subscriptions = Set<AnyCancellable>()
    @Published var isLoading: Bool = false
    @Published var error: CommonError?
    @Published var success: CommonError?
    @Published var alertContent: PopupContent?
}
