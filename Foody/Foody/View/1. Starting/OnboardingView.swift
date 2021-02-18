//
//  ContentView.swift
//  Foody
//
//  Created by An Nguyễn on 2/18/21.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.red)
                Text("Hello, world!")
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
