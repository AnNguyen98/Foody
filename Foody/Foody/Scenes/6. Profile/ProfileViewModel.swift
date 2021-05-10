//
//  ProfileViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/10/21.
//

import SwiftUI

final class ProfileViewModel: ViewModel, ObservableObject {
    var isRestaurant: Bool {
        Session.shared.user?.type == UserType.restaurant.rawValue
    }
    
    var isActive: Bool {
        Session.shared.user?.status == AccountStatus.active.rawValue
    }
}
