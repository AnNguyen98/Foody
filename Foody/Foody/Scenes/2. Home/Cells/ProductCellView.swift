//
//  Cell.swift
//  Foody
//
//  Created by MBA0283F on 5/5/21.
//

import SwiftUI

let scale: CGFloat =  kScreenSize.width / 375

struct ProductCellView: View {
    
    @State var voteCount: Int = Int.random(in: 1...5)
    var restaurant: Product = Product()
        
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {            Image("food1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250 * scale, height: 130 * scale)
                .clipShape(RoundedRectangle(cornerRadius: 0))
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Crispy Chicken Sandwich")
                
                Text("Korean BBQ")
                    .foregroundColor(Color(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)))
                    .font(.subheadline)
                
                HStack(spacing: 5) {
                    ForEach(0..<5) { index in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 16 * scale, height: 16 * scale)
                            .foregroundColor(index <= voteCount ? .yellow: .gray)
                            .onTapGesture {
                                voteCount = index
                            }
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text("0.00")
                        .bold()
                }
                .padding(.bottom, 10)
            }
            .font(.body)
            .foregroundColor(Color(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1)))
            .lineLimit(1)
            .padding(.horizontal, 10)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 5, x: 0.0, y: 2)
        .padding(.bottom, 15)
    }
}

//struct ProductCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCellView()
//    }
//}
