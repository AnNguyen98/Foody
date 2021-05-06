//
//  SeachViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import SwiftUI

final class SearchViewModel: ViewModel, ObservableObject {
    @Published var products: [Product] = (0...20).map({ _ in Product() })
    @Published var searchText: String = ""
    @Published var canLoadMore: Bool = true
    @Published var isLastRow: Bool = false
    var currentPage: Int = 0
    
    override init() {
        super.init()
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .removeDuplicates()
            .print("DEBUG - SearchViewModel")
            .sink(receiveValue: { (text) in
                self.searchProducts(with: text)
            })
            .store(in: &subscriptions)
    }
    
    func searchProducts(with text: String, page: Int = 0) {
        
    }
    
    func handleLoadMore() {
        searchProducts(with: searchText, page: currentPage + 1)
    }
    
    func handleRefreshData() {
        searchProducts(with: searchText)
    }
}
