//
//  SearchView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI

struct SearchView: View {
    @State private var score = 0
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack {
            TextField("Amount to transfer", value: $score, formatter: formatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("Your score was \(score).")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
