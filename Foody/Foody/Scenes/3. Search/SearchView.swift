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
    @State private var score = 0
    @State var searchViewObject = SearchViewObject()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        ScrollView(.vertical, content: {
            VStack {
                ForEach(0..<40) { (index) in
                    Text("Row -- \(index)")
                        .padding(.vertical)
                        .background(Color.green)
                }
            }
        })
        .introspectScrollView { scrollView in
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(searchViewObject, action: #selector(SearchViewObject.handleRefreshData(_ :)), for: .valueChanged)
            scrollView.refreshControl = refreshControl
        }
        .introspectNavigationController(customize: { (nav) in
            nav.navigationBar.barTintColor = .red
            var searchBar: UISearchBar = UISearchBar(frame: .init(x: 0, y: 0, width: 200, height: 20))

            nav.navigationItem.leftBarButtonItem = .init(customView: searchBar)
        })
//        .onRefresh {
//            print("OKKKK")
//        }
//        .isRefreshing(false)
//        .refreshControlTintColor(.black)
        .isScrollEnabled(true)
        .navigationSearchBarHiddenWhenScrolling(false)
        .navigationBarTitle("Home", displayMode: .automatic)
//        .navigationSearchBar({
//            SearchBar("Search", text: .constant(""), onEditingChanged: { onEditingChanged in
//
//            }, onCommit: {
//
//            })
//            .searchBarStyle(.prominent)
//        })
    }
}

extension SearchView {
    class SearchViewObject: NSObject {
        @objc func handleRefreshData(_ refreshControl: UIRefreshControl) {
            print("OKKKK")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                refreshControl.endRefreshing()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
    }
}
