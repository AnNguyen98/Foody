//
//  TabViews.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI
import Introspect

struct TabViews: View {
    @State private var tabItem: TabItems = .home
    
    var body: some View {
        VStack {
            UIKitTabView(selectedIndex: .constant(tabItem.rawValue)) {
                UIKitTabView.Tab(
                    view: NavigationView { HomeView() }.toAnyView
//                        .introspectNavigationController(customize: { (nav) in
//                            nav.interactivePopGestureRecognizer?.isEnabled = false
//                            nav.interactivePopGestureRecognizer?.delegate = coordinator
//                        })
                )
                
                UIKitTabView.Tab(view: NavigationView { SearchView() }.toAnyView)
                
                UIKitTabView.Tab(view: NavigationView { CartView() }.toAnyView)
                
                UIKitTabView.Tab(view: NavigationView { FavoritesView() }.toAnyView)
                
                UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                
            }
            
            BottomTabBar(currentItem: $tabItem)
                .frame(maxWidth: kScreenSize.width)
                .padding(.bottom, 20)
                .background(.white)
        }
        .ignoresSafeArea()
    }
}

extension TabViews {
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
            print(event)
            return true
        }
        
        
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
