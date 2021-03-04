//
//  TabViews.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI

struct TabViews: View {
    @State var tabItem: TabItems = .home
    
    var body: some View {
        VStack {
            VStack {
                switch tabItem {
                case .home:
                    Text("Home")
                case .likes:
                    Text("Likes")
                        .onAppear(perform: {
                            print("Likes")
                        })
                case .search:
                    Text("Search")
                        .onAppear(perform: {
                            print("Search")
                        })
                case .profile:
                    Text("Profile")
                        .onAppear(perform: {
                            print("Profile")
                        })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            BottomTabBar(currentItem: $tabItem)
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
