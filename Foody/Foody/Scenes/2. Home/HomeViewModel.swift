//
//  HomeViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import SwiftUI

final class HomeViewModel: ViewModel, ObservableObject {
    @Published var popularItems: [Product] = []
}
