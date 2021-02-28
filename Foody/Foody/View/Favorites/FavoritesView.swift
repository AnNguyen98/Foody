//
//  FavoritesView.swift
//  Foody
//
//  Created by An Nguyễn on 2/28/21.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], content: {
            LazyHGrid(rows: [GridItem(.fixed(5))], content: {
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
            })
        })
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
