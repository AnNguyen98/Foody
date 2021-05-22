//
//  ViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import Combine
import SwiftUI

class ViewModel {
    lazy var subscriptions = Set<AnyCancellable>()
    @Published var isLoading: Bool = false {
        didSet {
            UIApplication.shared.rootViewController?.view.isUserInteractionEnabled = !isLoading
            UIApplication.shared.topmostViewController?.view.isUserInteractionEnabled = !isLoading
        }
    }
    @Published var error: CommonError?
    @Published var success: CommonError?
    @Published var alertContent: PopupContent?
}
