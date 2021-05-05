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
    var coordinator = Coordinator()
    
    var body: some View {
        VStack {
            UIKitTabView(selectedIndex: .constant(tabItem.rawValue)) {
                UIKitTabView.Tab(
                    view: AnyView(
                        NavigationView {
                            HomeView()
                        }
                        .introspectNavigationController(customize: { (nav) in
                            nav.interactivePopGestureRecognizer?.isEnabled = false
                            nav.interactivePopGestureRecognizer?.delegate = coordinator
                        })
                    )
                )
                
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
