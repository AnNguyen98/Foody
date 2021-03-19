//
//  FavoritesView.swift
//  Foody
//
//  Created by An Nguyễn on 2/28/21.
//

import SwiftUI

struct FavoritesView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            IndefiniteProgressView()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
