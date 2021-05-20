//
//  ROrdersViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import Combine
import SwifterSwift

final class ROrdersViewModel: ViewModel, ObservableObject {
    @Published var orders: [[Order]] = []
    @Published var showSuccessPopup = false
    @Published var searchText: String = ""
    
    func prepareOrders(_ orders: [Order]) {
        var prepareOrders: [Order] = orders
        [OrderStatus.processing, OrderStatus.canceled, OrderStatus.shipping, OrderStatus.paymented]
            .forEach({ status in
                let processingOrders = prepareOrders.filter({ OrderStatus(rawValue: $0.status) == status }).sorted(by: { $0.orderTime < $1.orderTime })
                self.orders.append(processingOrders)
                prepareOrders.removeAll(processingOrders)
        })
    }
    
    func getOrders() {
        isLoading = true
        RestaurantServices.getOrders()
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (orders) in
                self.prepareOrders(orders)
            }
            .store(in: &subscriptions)
    }
    
    func verifySendingOrder(order: Order) {
        RestaurantServices.verifySendingOrder(id: order._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (order) in
                self.showSuccessPopup = true
            }
            .store(in: &subscriptions)
    }
    
    func verifySendOrder(order: Order) {
        RestaurantServices.verifySendOrder(id: order._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (order) in
                self.showSuccessPopup = true
            }
            .store(in: &subscriptions)
    }
}
