//
//  OrderDetailsViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 03/07/2021.
//

import Combine

final class OrderDetailsViewModel: ViewModel, ObservableObject {
    @Published var order: Order = Order()
    
    func getOrderInfo(orderID: String) {
        isLoading = true
        
    }
}
