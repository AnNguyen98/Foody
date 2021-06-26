//
//  ViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import Combine
import SwiftUI
import SwifterSwift

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
    var tabIndex: Int? { nil }
    
    init() {
        if let _ = tabIndex {
            NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .refreshTab, object: nil)
        }
        guard Session.shared.currentTab == tabIndex else {
            return
        }
        setupData()
    }
    
    func setupData() {
        
    }
    
    @objc func refreshData(_ notification: Notification) {
        guard let index = notification.object as? Int, index == tabIndex else {
            return
        }
        setupData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
