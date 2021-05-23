//
//  TabViews.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI

struct TabViews: View {
    @State private var indexSelected: Int = 0
    
    var body: some View {
        VStack {
            if isResraurant {
                UIKitTabView(selectedIndex: $indexSelected) {
                    
                    UIKitTabView.Tab(view: NavigationView { RHomeView() }.toAnyView )
                    
                    UIKitTabView.Tab(view: NavigationView { ROrdersView() }.toAnyView)
                                        
                    UIKitTabView.Tab(view: NavigationView { RChartsView() }.toAnyView)
                    
                    UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                }
            } else {
                UIKitTabView(selectedIndex: $indexSelected) {
                    
                    UIKitTabView.Tab(view: NavigationView { HomeView() }.toAnyView )
                    
                    UIKitTabView.Tab(view: NavigationView { SearchView() }.toAnyView)
                                        
                    UIKitTabView.Tab(view: NavigationView { FavoritesView() }.toAnyView)
                    
                    UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                }
            }
            
            BottomTabBar(tabItems: tabItems, indexSelected: $indexSelected)
                .frame(maxWidth: kScreenSize.width)
                .padding(.bottom, 20)
        }
        .ignoresSafeArea()
    }
}

extension TabViews {
    private var tabItems: [TabItem] {
        if isResraurant {
            return [.home, .orders, .charts, .profile]
        }
        return [.home, .search, .likes, .profile]
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
