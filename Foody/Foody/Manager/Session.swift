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
    
    var currentUser: User? {
        set {
            Defaults.currentUser = newValue
        } get {
            Defaults.currentUser
        }
    }
    
    var accessTokens: String? {
        set {
            Defaults.accessTokens = newValue
        } get {
            Defaults.accessTokens
        }
    }
    
    var isShowedOnboarding: Bool {
        set {
            Defaults.isShowedOnboarding = newValue
        } get {
            Defaults.isShowedOnboarding
        }
    }
    
    
}

extension Session {
    func reset() {
        Defaults.removeAll()
    }
}
