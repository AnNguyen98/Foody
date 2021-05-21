//
//  RHomeViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/18/21.
//

import SwiftUI
import SwifterSwift

final class RHomeViewModel: ViewModel, ObservableObject {
    private var displayProducts: [Product] = []
    private var nextPage = false
    private var currentPage: Int = 0
    
    @Published var products: [Product] = []//(0...20).map({ _ in Product() })
    @Published var searchText: String = ""
    @Published var isLastRow: Bool = false
    
    var canLoadMore: Bool  {
        isLastRow && nextPage
    }
    
    override init() {
        super.init()
        getProducts()
        setupObservers()
    }
    
    func setupObservers() {
        $searchText
            .debounce(for: .seconds(0.4), scheduler: DispatchQueue.main)
            .map({ $0.trimmed })
            .removeDuplicates()
            .sink { (text) in
                if text.isEmpty {
                    self.displayProducts = self.products
                } else {
                    self.handleSearch()
                }
        }
        .store(in: &subscriptions)
    }
    
    func getProducts(page: Int = 0) {
        guard !isLoading else { return }
        isLoading = true
        RestaurantServices.getProducts()
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (response) in
                if response.currentPage > 0 {
                    self.products = response.products
                } else {
                    self.products += response.products
                }
                self.nextPage = response.nextPage
                self.currentPage = response.currentPage
            }
            .store(in: &subscriptions)
    }
    
    func handleSearch() {
        isLoading = true
        CommonServices.searchProducts(productName: searchText)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (response) in
                self.displayProducts = response.products
            }
            .store(in: &subscriptions)
    }
    
    func refreshData() {
        getProducts()
    }
    
    func handleLoadMore() {
        getProducts(page: currentPage + 1)
    }
}

