//
//  ROrderDetails.swift
//  Foody
//
//  Created by An Nguyễn on 03/07/2021.
//

import SwiftUI

struct ROrderDetails: View {
    var viewModel = OrderDetailsViewModel()
    var orderID: String = ""
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                viewModel.getOrderInfo(orderID: orderID)
            }
    }
}

struct ROrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        ROrderDetails()
    }
}
