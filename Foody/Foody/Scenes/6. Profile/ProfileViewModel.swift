//
//  ProfileViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/10/21.
//

import SwiftUI

final class ProfileViewModel: ViewModel, ObservableObject {
    @Published var isLogged: Bool = true
    var canLoadedInfo: Bool = true
    @Published var userPreview: User? {
        didSet {
            if canLoadedInfo {
                canLoadedInfo = false
                getUserPreviewIfNeeded()
            }
        }
    }
    
    var isRestaurant: Bool {
        user.type == UserType.restaurant.rawValue
    }
    
    var user: User {
        if userPreview != nil  {
            return userPreview ?? User()
        }
        return Session.shared.user ?? User()
    }
    
    var restaurant: Restaurant {
        Session.shared.restaurant ?? Restaurant()
    }
    
    var isActive: Bool {
        Session.shared.user?.status == AccountStatus.active.rawValue
    }
    
    override var tabIndex: Int? { 3 }
    
    override func setupData() {
        getUserInfo()
    }
    
    func getUserPreviewIfNeeded() {
        isLoading = true
        AccountService.getUserInformation(id: user._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (user) in
                self.userPreview = user
            }
            .store(in: &subscriptions)
    }
    
    func getUserInfo() {
        isLoading = true
        AccountService.getInformation()
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                Session.shared.user = res.user
                Session.shared.restaurant = res.restaurant
            }
            .store(in: &subscriptions)
    }
    
    func logout() {
        isLoading = true
        AccountService.logout()
        Session.shared.reset()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
            self.isLoading = false
            self.isLogged = false
        }
    }
}
