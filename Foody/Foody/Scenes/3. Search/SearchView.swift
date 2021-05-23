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
    @State private var product: Product?
    
    var body: some View {
        LazyVGrid(columns: defaultGridItemLayout, spacing: 0) {
            ForEach(viewModel.products, id: \._id) { product in
                ZStack(alignment: .topTrailing) {
                    ProductCellView(product: product)
                        .frame(height: 250)
                    
                    Button(action: {
                        if product.isLiked {
                            self.product = product
                        } else {
                            viewModel.addToFavorite(product)
                        }
                    }, label: {
                        Image(systemName: SFSymbols.heartFill)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(product.isLiked ? .red: .gray)
                            .padding(8)
                            
                    })
                }
                .onAppear(perform: {
                    if product == viewModel.products.last {
                        viewModel.isLastRow = true
                    }
                })
                .onTapGesture {
                    
                }
            }
        }
        .prepareForLoadMore(loadMore: {
            handleLoadMore()
        }, showIndicator: viewModel.canLoadMore && viewModel.isLastRow)
        .onRefresh {
            handleRefresh()
        }
        .navigationSearchBar({
            SearchBar("Enter product name...", text: $viewModel.searchText)
                .showsCancelButton(true)
                .searchBarStyle(.default)
                .returnKeyType(.search)
                .onCancel {
                    viewModel.isLastRow = false
                }
        })
        .navigationBarTitle("Search", displayMode: .automatic)
        .setupNavigationBar()
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .addEmptyView(isEmpty: viewModel.products.isEmpty,
                      viewModel.searchText.isEmpty ? "Please enter the name of the product you are looking for.": "No items found.")
        .alert(item: $product, content: { product in
            Alert(title: Text("Delete favorite"),
                  message: Text("Are you want to delete this item in your favorites?"),
                  primaryButton: .destructive(Text("Delete"), action: {
                    viewModel.deleteInFavorite(product)
                  }),
                  secondaryButton: .cancel()
            )
        })
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
