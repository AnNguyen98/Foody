//
//  ROrdersViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import Combine
import SwifterSwift

final class ROrdersViewModel: ViewModel, ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedIndex = 0
    @Published var cureentOrder: Order?
    @Published var orders: [[Order]] = []
    @Published var searchResults: [Order] = []
    
    var isSearching: Bool {
        !searchText.isEmpty || searchText != ""
    }
    
    var ordersData: [Order] = [] {
        didSet {
            prepareOrders(ordersData)
        }
    }
    
    var currentOrders: [Order] {
        isSearching ? searchResults: orders[safeIndex: selectedIndex] ?? []
    }
    
    override var tabIndex: Int? { 1 }
    
    override func setupData() {
        getOrders()
        
        $searchText.sink { (text) in
            self.searchResults = self.ordersData.filter({ $0._id.lowercased().contains(text.trimmed.lowercased())})
        }
        .store(in: &subscriptions)
    }
    
    func detailsViewModel(_ order: Order) -> RProductDetailsViewModel {
        RProductDetailsViewModel(order.product)
    }
    
    func profileViewModel(_ userId: String) -> ProfileViewModel {
        let vm = ProfileViewModel()
        vm.userPreview = User(_id: userId)
        print("DEBUG - \(vm.userPreview?._id ?? "")")
        return vm
    }
    
    func prepareOrders(_ orders: [Order]) {
        var prepareOrders: [Order] = orders
        self.orders.removeAll()
        [OrderStatus.pending, OrderStatus.processing, OrderStatus.canceled, OrderStatus.shipping, OrderStatus.paymented]
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
    
    func verifyOrder(order: Order, status: OrderStatus, canceledReason: String? = "Canceled by the restaurant") {
        guard !isLoading else { return }
        var params: Parameters = [
            "_id": order._id,
            "\(status.rawValue)Time": Date().dateTimeString(),
            "status": status.rawValue
        ]
        if status == .canceled {
            params["canceledReason"] = canceledReason
        }
        
        isLoading = true
        CommonServices.verifyOrder(params)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (_) in
                var newOrder: Order = order
                newOrder.status = status.rawValue
                
                self.ordersData.removeAll(order)
                self.ordersData.append(newOrder)
            }
            .store(in: &subscriptions)
    }
}
