//
//  FavoritesView.swift
//  Foody
//
//  Created by An Nguyễn on 2/28/21.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        LazyVGrid(columns: defaultGridItemLayout, spacing: 0) {
            ForEach(viewModel.products, id: \._id) { product in
                NavigationLink(destination: productView(with: product), label: {
                    ZStack(alignment: .topTrailing) {
                        ProductCellView(product: product)
                        
                        Button(action: {
                            viewModel.deleteFavorite(id: product._id)
                        }, label: {
                            Image(systemName: SFSymbols.heartFill)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.red)
                                .padding(8)
                                
                        })
                    }
                    .frame(maxWidth: (kScreenSize.width - 15 * 3) / 2)
                    .onAppear(perform: {
                        if product == viewModel.products.last {
                            viewModel.isLastRow = true
                        }
                    })
                })
            }
        }
        .prepareForLoadMore(loadMore: {
            handleLoadMore()
        }, showIndicator: viewModel.canLoadMore)
        .onRefresh {
            handleRefresh()
        }
        .navigationBarTitle("Favorites", displayMode: .automatic)
        .setupNavigationBar()
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .setupBackgroundNavigationBar()
    }
    
    func productView(with product: Product) -> FoodDetailsView {
        FoodDetailsView(viewModel: viewModel.detailsViewModel(with: product))
    }
}

extension FavoritesView {
    private func handleRefresh() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            viewModel.handleRefreshData()
        }
    }
    
    private func handleLoadMore() {
        viewModel.handleLoadMore()
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoritesView()
        }
    }
}
