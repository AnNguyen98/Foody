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
    @Published var selectedIndex = 0
    
    var currentOrders: [Order] {
        orders[safeIndex: selectedIndex] ?? []
    }
    
    override init() {
        super.init()
        getOrders()
    }
    
    func prepareOrders(_ orders: [Order]) {
        var prepareOrders: [Order] = orders
        [OrderStatus.processing, OrderStatus.canceled, OrderStatus.shipping, OrderStatus.paymented]
            .forEach({ status in
                let processingOrders = prepareOrders.filter({ OrderStatus(rawValue: $0.status) == status })
                                                    .sorted(by: { $0.orderTime < $1.orderTime })
                self.orders.append(processingOrders)
                prepareOrders.removeAll(processingOrders)
        })
    }
    
    func getOrders() {
        guard !isLoading else { return }
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
    
    func verifySendingOrder(order: Order, status: OrderStatus) {
        guard !isLoading else { return }
        isLoading = true
        RestaurantServices.verifySendingOrder(id: order._id, status: status)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (_) in
                var order: Order = order
                order.status = OrderStatus.shipping.rawValue
                self.orders[self.selectedIndex].removeAll(order)
                if self.orders.count > 2 {
                    self.orders[2].append(order)
                }
                self.showSuccessPopup = true
            }
            .store(in: &subscriptions)
    }
    
    func verifySendOrder(order: Order) {
        guard !isLoading else { return }
        isLoading = true
        RestaurantServices.verifySendOrder(id: order._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (_) in
                var order: Order = order
                order.status = OrderStatus.paymented.rawValue
                self.orders[self.selectedIndex].removeAll(order)
                if self.orders.count > 3 {
                    self.orders[3].append(order)
                }
                self.showSuccessPopup = true
            }
            .store(in: &subscriptions)
    }
}
