//
//  RHomeViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/18/21.
//

import SwiftUI
import SwifterSwift

final class RHomeViewModel: ViewModel, ObservableObject {
    private var nextPage = false
    private var currentPage: Int = 0
    
    @Published var products: [Product] = []
    @Published var searchResults: [Product] = []
    @Published var searchText: String = ""
    @Published var isLastRow: Bool = false
    
    var displayProducts: [Product] {
        searchText.trimmed == "" ? products: searchResults
    }
    
    var canLoadMore: Bool  {
        !searchText.isEmpty ? false: isLastRow && nextPage
    }
    
    override init() {
        super.init()
        getProducts()
        setupObservers()
    }
    
    func detailViewModel(_ product: Product) -> RProductDetailsViewModel {
        RProductDetailsViewModel(product)
    }
    
    func setupObservers() {
        $searchText
            .debounce(for: .seconds(0.4), scheduler: DispatchQueue.main)
            .map({ $0.trimmed })
            .removeDuplicates()
            .sink { (text) in
                if text.isEmpty {
                    self.searchResults.removeAll()
                } else {
                    self.handleSearch()
                }
        }
        .store(in: &subscriptions)
    }
    
    func getProducts(page: Int = 0) {
        guard !isLoading else { return }
        isLoading = true
        RestaurantServices.getProducts(page: page)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (response) in
                if response.page > 0 {
                    self.products += response.products
                } else {
                    self.products = response.products
                }
                self.nextPage = response.nextPage
                self.currentPage = response.page
            }
            .store(in: &subscriptions)
    }
    
    func handleSearch(page: Int = 0) {
        CommonServices.searchProducts(productName: searchText, page: page)
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (response) in
                self.searchResults = response.products
            }
            .store(in: &subscriptions)
    }
    
    func refreshData() {
        products.removeAll()
        searchResults.removeAll()
        currentPage = 0
        
        getProducts()
    }
    
    func handleLoadMore() {
        if searchText.trimmed == "" {
            getProducts(page: currentPage + 1)
        }
    }
}

