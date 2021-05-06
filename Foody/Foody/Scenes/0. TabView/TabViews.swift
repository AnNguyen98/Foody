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
            ZStack(alignment: .bottomTrailing) {
                UIKitTabView(selectedIndex: $indexSelected) {
                    UIKitTabView.Tab(view: NavigationView { HomeView() }.toAnyView )
                    
                    UIKitTabView.Tab(view: NavigationView { SearchView() }.toAnyView)
                    
                    UIKitTabView.Tab(view: NavigationView { CartView() }.toAnyView)
                    
                    UIKitTabView.Tab(view: NavigationView { FavoritesView() }.toAnyView)
                    
                    UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                    
                }
                
                Button(action: {
                    print("OKKK")
                }, label: {
                    GifView(gifName: "cart-preview")
                        .frame(.init(width: 70, height: 70))
                        .clipShape(Circle())
                        .opacity(0.96)
                })
                .padding()
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
