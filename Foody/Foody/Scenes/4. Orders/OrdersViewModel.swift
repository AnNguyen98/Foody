
//
//  CartViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/10/21.
//

import SwiftUI
import SwifterSwift

final class OrdersViewModel: ViewModel, ObservableObject {
    @Published var cancelOrder: Order?
    @Published var showSuccessPopup = false
    @Published var searchText: String = ""
    @Published var selectedIndex = 0
    @Published var orders: [[Order]] = []
    
    var ordersData: [Order] = [] {
        didSet {
            prepareOrders(ordersData)
        }
    }
    
    var currentOrders: [Order] {
        orders[safeIndex: selectedIndex] ?? []
    }
    
    override init() {
        super.init()
        getOrders()
    }
    
    func detailsViewModel(_ order: Order) -> ProductDetailsViewModel {
        ProductDetailsViewModel(id: order.product._id)
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
                self.ordersData = orders
            }
            .store(in: &subscriptions)
    }
    
    func cancelOrder(_ order: Order) {
        isLoading = false
        CustomerServices.cancelOrder(id: order._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (_) in
                var newOrder: Order = order
                newOrder.status = OrderStatus.canceled.rawValue
                // TODO: Optimize...
                self.ordersData.removeAll(order)
                self.ordersData.append(newOrder)
            }
            .store(in: &subscriptions)

    }
}
