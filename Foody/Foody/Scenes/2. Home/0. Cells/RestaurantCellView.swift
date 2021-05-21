//
//  RestaurantView.swift
//  Foody
//
//  Created by MBA0283F on 5/5/21.
//

import SwiftUI

struct RestaurantCellView: View {
    @State var voteCount: Int = Int.random(in: 1...5)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 13) {
                    ForEach(0..<3) { _ in
                        Image("food1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 155 * scale, height: 85 * scale)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding([.horizontal, .top])
            }
            
            Text("Conrad Chicago Restaurant")
                .foregroundColor(Color(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1)))
                .font(.title3)
                .padding(.horizontal)
            
            Text("963 Madyson Drive Suite 679")
                .padding(.horizontal)
            
            HStack(spacing: 5) {
                ForEach(0..<5) { index in
                    Image(systemName: SFSymbols.starFill)
                        .resizable()
                        .frame(width: 16 * scale, height: 16 * scale)
                        .foregroundColor(index <= voteCount ? .yellow: .gray)
                        .onTapGesture {
                            voteCount = index
                        }
                }
                
                Spacer(minLength: 0)
                
                Text("Open 8:00 AM")
            }
            .padding(.top, 5)
            .padding([.horizontal, .bottom])
        }
        .font(.body)
        .lineLimit(1)
        .foregroundColor(Color(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 5, x: 0.0, y: 2)
    }
}

//struct RestaurantCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantCellView()
//    }
//}
