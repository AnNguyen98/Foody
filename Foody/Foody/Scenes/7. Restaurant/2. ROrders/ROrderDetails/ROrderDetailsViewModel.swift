//
//  ROrderDetailsViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import Combine

final class ROrderDetailsViewModel: ViewModel, ObservableObject {
    var order: Order
    
    init(_ order: Order = Order()) {
        self.order = order
    }
}
