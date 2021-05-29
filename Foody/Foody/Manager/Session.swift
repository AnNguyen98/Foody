//
//  Session.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import Foundation
import SwiftyUserDefaults

final class Session {
    private init() { }
    static let shared = Session()
    
    var user: User? {
        set {
            Defaults.currentUser = newValue
        } get {
            Defaults.currentUser
        }
    }
    
    var accessToken: String? {
        set {
            Defaults.accessToken = newValue
        } get {
            Defaults.accessToken
        }
    }
    
    var isShowedOnboarding: Bool {
        set {
            Defaults.isShowedOnboarding = newValue
        } get {
            Defaults.isShowedOnboarding
        }
    }
    
    var currentEmail: String {
        set {
            Defaults.currentEmail = newValue
        } get {
            Defaults.currentEmail
        }
    }
    
    var isResraurant: Bool {
        user?.type == UserType.restaurant.rawValue
    }
    
    var restaurant: Restaurant? {
        set {
            Defaults.restaurant = newValue
        } get {
            Defaults.restaurant
        }
    }
    
    var favorites: [Product] = []
    
    var haveNotifications: Bool = false
}

extension Session {
    func reset() {
        Defaults.removeAll()
    }
}
