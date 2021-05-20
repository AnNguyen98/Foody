//
//  TrendingProductsView.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

struct TrendingProductsView: View {
    @StateObject private var viewModel = TrendingProductsViewModel()
    
    var body: some View {
        LazyVGrid(columns: defaultGridItemLayout, spacing: 0) {
            ForEach(viewModel.products, id: \._id) { product in
                ZStack(alignment: .topTrailing) {
                    ProductCellView()
                    
                    Button(action: {
                        
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
                
            }
        }
        .prepareForLoadMore(loadMore: {
            handleLoadMore()
        }, showIndicator: viewModel.canLoadMore && viewModel.isLastRow)
        .onRefresh {
            handleRefresh()
        }
        .setupBackgroundNavigationBar()
        .navigationBarTitle("Trending", displayMode: .automatic)
        .setupNavigationBar()
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .onAppear {
            viewModel.getPopularRestaurants()
        }
    }
}

extension TrendingProductsView {
    private func handleFavorite(_ id: String) {
        
    }
    
    private func handleRefresh() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            viewModel.handleRefreshData()
        }
    }
    
    private func handleLoadMore() {
        viewModel.handleLoadMore()
    }
}

struct TrendingProductsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrendingProductsView()
        }
    }
}
