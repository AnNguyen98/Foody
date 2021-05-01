//
//  DefaultsKeys.swift
//  Foody
//
//  Created by MBA0283F on 4/23/21.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var currentEmail: DefaultsKey<String> { .init("currentEmail", defaultValue: "") }
    var accessTokens: DefaultsKey<String?> { .init("accessTokens") }
    var currentUser: DefaultsKey<User?> { .init("currentUser") }
    var isShowedOnboarding: DefaultsKey<Bool> { .init("isShowedOnboarding", defaultValue: false) }
}
