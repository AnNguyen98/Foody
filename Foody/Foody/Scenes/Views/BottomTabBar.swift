//
//  TabBarView.swift
//  Foody
//
//  Created by MBA0283F on 3/3/21.
//

import SwiftUI
import UIKit

enum TabItems: Int, CaseIterable {
    case home, likes, search, profile
    
    var id: UUID { return UUID() }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .likes:
            return "Likes"
        case .search:
            return "Search"
        default:
            return "Profile"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "house.fill"
        case .likes:
            return "heart.fill"
        case .search:
            return "magnifyingglass"
        default:
            return "person.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .purple
        case .likes:
            return .pink
        case .search:
            return .orange
        default:
            return .primary
        }
    }
}

struct BottomTabBar: View {
    @Binding var currentItem: TabItems
    
    var body: some View {
        VStack {
            Divider()
            HStack(spacing: 20) {
                Spacer()
                TabItem(item: .home, currentItem: $currentItem)
                TabItem(item: .likes, currentItem: $currentItem)
                TabItem(item: .search, currentItem: $currentItem)
                TabItem(item: .profile, currentItem: $currentItem)
                Spacer()
            }
        }
    }
}

struct TabItem: View {
    var item: TabItems
    @Binding var currentItem: TabItems
    @State private var isClicking: Bool = false
    private var isSelected: Bool { item == currentItem }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: item.imageName)
                .resizable()
                .frame(width: 17, height: 17)
            Text(isSelected ? item.title: "")
                .font(.system(size: 11, weight: .bold, design: .default))
                .padding(.leading, isSelected ? 5: 0)
        }
        .frame(width: isSelected ? 90: 30)
        .padding(.horizontal, isSelected ? 15: 5)
        .padding(.vertical, 10)
        .scaleEffect(isClicking ? 1.2: isSelected ? 1.1: 1)
        .animation(.interpolatingSpring(mass: 1.0, stiffness: 500,
                                        damping: 14, initialVelocity: 0.2))
       
        .foregroundColor(isSelected ? item.color: Color.gray)
        .background(isSelected ? item.color.opacity(0.3): Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .animation(.interpolatingSpring(mass: 1.0, stiffness: 200,
                                        damping: 20, initialVelocity: 0.1))
        .onTapGesture {
            currentItem = item
            isClicking = true
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
                isClicking = false
            }
        }
    }
}