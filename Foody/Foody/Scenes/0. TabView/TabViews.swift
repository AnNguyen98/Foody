//
//  TabViews.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI
import Introspect

struct TabViews: View {
    @State private var indexSelected: Int = 0
    
    var body: some View {
        VStack {
            UIKitTabView(selectedIndex: $indexSelected) {
                UIKitTabView.Tab(view: NavigationView { HomeView() }.toAnyView )
                
                UIKitTabView.Tab(view: NavigationView { SearchView() }.toAnyView)
                
                UIKitTabView.Tab(view: NavigationView { CartView() }.toAnyView)
                
                UIKitTabView.Tab(view: NavigationView { FavoritesView() }.toAnyView)
                
                UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                
            }
            
            BottomTabBar(tabItems: [.home, .search, .carts, .likes, .profile],
                         indexSelected: $indexSelected)
                .frame(maxWidth: kScreenSize.width)
                .padding(.bottom, 20)
        }
        .background(.white)
        .ignoresSafeArea()
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
