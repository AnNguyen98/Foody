//
//  FavoritesView.swift
//  Foody
//
//  Created by An Nguyễn on 2/28/21.
//

import SwiftUI
import SwiftUIX

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @State private var isActiveDetails: Bool = false
    
    var body: some View {
        LazyVGrid(columns: defaultGridItemLayout, spacing: 0) {
            ForEach(viewModel.products, id: \._id) { item in
                let product = item.product
                
                ZStack(alignment: .topTrailing) {
                    NavigationLink(destination: FoodDetailsView(viewModel: viewModel.detailsViewModel(product)),
                                   isActive: $isActiveDetails, label: {
                                        EmptyView()
                                   })
                    
                    ProductCellView(product: product)
                        .frame(height: 250)
                    
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
                    if product == viewModel.products.last?.product {
                        viewModel.isLastRow = true
                    }
                })
                .onTapGesture {
                    isActiveDetails = true
                }
            }
        }
        .prepareForLoadMore(loadMore: {
            handleLoadMore()
        }, showIndicator: viewModel.canLoadMore && viewModel.isLastRow)
        .onRefresh {
            handleRefresh()
        }
        .navigationBarTitle("Favorites", displayMode: .automatic)
        .setupNavigationBar()
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .addEmptyView(isEmpty: viewModel.products.isEmpty && !viewModel.isLoading)
    }
}

extension FavoritesView {
    private func handleRefresh() {
        viewModel.handleRefreshData()
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
