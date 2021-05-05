//
//  TrendingProductsView.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI
import SwiftUIX

struct TrendingProductsView: View {
    @StateObject private var viewModel = TrendingProductsViewModel()
    
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 15) {
                ForEach(viewModel.products, id: \._id) { restaurant in
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
                        if restaurant == viewModel.products.last {
                            viewModel.isLastRow = true
                        }
                    })
                    
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
        .onRefresh {
            handleRefresh()
        }
        .background(.white)
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
