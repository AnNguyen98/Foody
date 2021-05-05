//
//  Cell.swift
//  Foody
//
//  Created by MBA0283F on 5/5/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCellView: View {
    
    @State var voteCount: Int = Int.random(in: 1...5)
    var restaurant: Product = Product()
    
    private let scale: CGFloat =  kScreenSize.width / 375
    
    var body: some View {
        VStack(alignment: .leading) {
            AnimatedImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/b/bb/Pizza_Vi%E1%BB%87t_Nam_%C4%91%E1%BA%BF_d%C3%A0y%2C_x%C3%BAc_x%C3%ADch_%28SNaT_2018%29_%287%29.jpg"), options: [.progressiveLoad, .delayPlaceholder])
                .resizable()
                .placeholder(UIImage(named: "default-thumbnail"))
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .frame(width: 250 * scale, height: 130 * scale)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                Text("Crispy Chicken Sandwich")
                
                Text("Korean BBQ")
                    .foregroundColor(Color(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)))
                    .font(.subheadline)
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 15 * scale, height: 15 * scale)
                            .foregroundColor(index <= voteCount ? .yellow: .gray)
                            .onTapGesture {
                                voteCount = index
                            }
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text("0.00")
                        .systemBold(size: 15)
                }
                .padding(.bottom, 10)
            }
            .lineLimit(1)
            .padding(.horizontal, 6)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .font(.body)
        .foregroundColor(Color(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1)))
        .background(Color.white)
        .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0)
    }
}

//struct ProductCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCellView()
//    }
//}
