//
//  SearchView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI
import SwiftUIX
import Introspect

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        ZStack {
            Colors.redColorCustom
                .ignoresSafeArea()
                        
            VStack {
                HStack {
                    Text("Results: \(viewModel.items.count) items")
                        .systemBold(size: 16)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                ScrollView(.vertical) {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.items, id: \._id) { item in
                            Text("Item \(item._id)")
                                .foregroundColor(.white)
                                .font(.body)
                                .frame(width: kScreenSize.width - 40, height: 50)
                                .background(Color.red)
                                .onAppear(perform: {
                                    if item == viewModel.items.last {
                                        viewModel.isLastRow = true
                                    }
                                })
                                .onDisappear(perform: {
                                    print("DEBUG - onDisappear")
                                })
                                .padding(.horizontal, 20)
                        }
                    }
                    
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
                .animation(.spring())
                
            }
            .padding(.top, 20)
            .background(Color.white)
        }
        .navigationSearchBar({
            SearchBar("Search...", text: $viewModel.searchText)
                .showsCancelButton(true)
                .searchBarStyle(.default)
                .returnKeyType(.search)
        })
        .navigationBarTitle("Search", displayMode: .large)
        .onAppear(perform: {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 34),
                .foregroundColor: UIColor.white,
            ]
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().largeTitleTextAttributes = titleTextAttributes
            UINavigationBar.appearance().barTintColor = Colors.redColorCustom.toUIColor()
        })
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .background(Color.white)
        .handleErrors($viewModel.error)
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
