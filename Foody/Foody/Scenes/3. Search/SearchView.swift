//
//  SearchView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI
import SwiftUIX

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(viewModel.products, id: \._id) { product in
                    ProductCellView()
                }
            }
            .padding([.horizontal, .top])
            
            if viewModel.canLoadMore, viewModel.isLastRow {
                ActivityIndicator()
                    .style(.regular)
                    .tintColor(.black)
                    .onAppear {
                        handleLoadMore()
                    }
                    .padding(.bottom, 8)
            }
        }
        .navigationSearchBar({
            SearchBar("Enter product name...", text: $viewModel.searchText)
                .showsCancelButton(true)
                .searchBarStyle(.default)
                .returnKeyType(.search)
        })
        .background(Color.white)
        .navigationBarTitle("Search", displayMode: .automatic)
        .setupNavigationBar()
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .setupBackgroundNavigationBar()
    }
}

extension SearchView {
    private func handleRefresh() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            viewModel.handleRefreshData()
        }
    }
    
    private func handleLoadMore() {
        viewModel.handleLoadMore()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
    }
}
