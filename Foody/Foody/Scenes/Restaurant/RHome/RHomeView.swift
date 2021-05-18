
//
//  HomeView.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI
import SwifterSwift
import SwiftUIX

struct RHomeView: View {
    @StateObject var viewModel = RHomeViewModel()
        
    var body: some View {
        LazyVStack(spacing: 15) {
            ForEach(viewModel.products, id: \._id) { product in
                NavigationLink(destination: RestaurantDetailsView(), label: {
                    ProductCellView()
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
        }, showIndicator: viewModel.canLoadMore && viewModel.isLastRow)
        .onRefresh {
            refreshData()
        }
        .background(.white)
        .setupBackgroundNavigationBar()
        .navigationSearchBar({
            SearchBar("Enter product name...", text: $viewModel.searchText)
                .showsCancelButton(true)
                .searchBarStyle(.default)
                .returnKeyType(.search)
        })
        .navigationBarItems(
            trailing: NotificationsView()
        )
        .navigationBarTitle("Home", displayMode: .automatic)
        .setupNavigationBar()
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .onAppear {
            setupData()
        }
    }
}

extension RHomeView {
    private func handleLoadMore() {
        viewModel.handleLoadMore()
    }
    
    func setupData() {
        
    }
    
    func refreshData() {
        
    }
}

struct RHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RHomeView()
        }
    }
}
