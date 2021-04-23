//
//  DefaultsKeys.swift
//  Foody
//
//  Created by MBA0283F on 4/23/21.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var accessTokens: DefaultsKey<String?> { .init("accessTokens") }
    var currentUser: DefaultsKey<User?> { .init("currentUser") }
}
