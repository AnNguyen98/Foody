//
//  TabViews.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI

struct TabViews: View {
    @State private var tabItem: TabItems = .home
    
    var body: some View {
        VStack {
            UIKitTabView(selectedIndex: .constant(tabItem.rawValue)) {
                UIKitTabView.Tab(view: AnyView(NavigationView { HomeView() }))
                
                UIKitTabView.Tab(view: AnyView(NavigationView { SearchView() }))
                
                UIKitTabView.Tab(view: AnyView(NavigationView { CartView() }))
                
                UIKitTabView.Tab(view: AnyView(NavigationView { FavoritesView() }))
                
                UIKitTabView.Tab(view: AnyView(NavigationView { ProfileView() }))
                
            }
            
            BottomTabBar(currentItem: $tabItem)
                .frame(maxWidth: kScreenSize.width)
                .padding(.bottom, 20)
        }
        .ignoresSafeArea()
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
