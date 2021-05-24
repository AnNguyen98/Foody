//
//  RestaurantDetailsViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

final class RestaurantDetailsViewModel: ViewModel, ObservableObject {
    var id: String
    
    init(id: String = "") {
        self.id = id
        
        super.init()
    }
}
