//
//  SeachViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import SwiftUI

final class SearchViewModel: ViewModel, ObservableObject {
    @Published var items: [Product] = (0...20).map({ _ in Product() })
    @Published var searchText: String = ""
    @Published var canLoadMore: Bool = true
    @Published var isLastRow: Bool = false
    
    
    func handleLoadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.items += (0...20).map({ _ in Product() })
            self.isLastRow = false
        }
    }
    
    func handleRefreshData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.items = (0...20).map({ _ in Product() })
            self.isLoading = false
        }
    }
}
