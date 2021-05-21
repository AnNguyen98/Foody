//
//  RestaurantView.swift
//  Foody
//
//  Created by An Nguyễn on 2/27/21.
//

import SwiftUI

struct RestaurantDetailsView: View {
    let menus = ["Popular items", "Salads", "Chicken", "Soups", "Vegetables", "Noodles", "Drink"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                        .fontWeight(.regular)
                }
                .foregroundColor(Colors.redColorCustom)
                Text("Conrad Chicago Restaurant")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)
                
                Text("963 Madyson Drive Suite 679")
                
                HStack {
                    ForEach(0..<5) { _ in
                        Image(systemName: SFSymbols.starFill)
                            .foregroundColor(.yellow)
                    }
                    Text("( 245 reviews )")
                        .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                }
                
                HStack {
                    VStack {
                        Text("Delivery")
                        Text("Free")
                            .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                    }
                    VStack {
                        Text("Open time")
                        Text("8:00 AM")
                            .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                    }
                }
                
                Group {
                    Divider()
                    HStack {
                        CircleButton(systemName:  SFSymbols.squareAndArrowUp, color: .black,
                                     action: { })
                        
                        CircleButton(systemName: SFSymbols.starFill, color: .black,
                                     action: { })
                        
                        CircleButton(systemName: SFSymbols.location, color: .black,
                                     action: { })
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Contact")
                                .frame(width: 113, height: 36)
                                .foregroundColor(Colors.redColorCustom)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 36 / 2)
                                        .stroke(Colors.redColorCustom, lineWidth: 2)
                                    
                                )
                        })
                    }
                    Divider()
                }
                
                Text("Feature items:")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<10) { _ in
                            VStack(alignment: .leading) {
                                Image("food_simple")
                                    .resizable()
                                    .frame(width: kScreenSize.width * 343 / 380,
                                           height: 147)
                                Text("Crispy Chicken Sandwich")
                                Text("$25.00")
                                    .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                            }
                            .font(.system(size: 15))
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Menu")
                    ForEach(menus, id: \.self) { value in
                        Button(action: {}, label: {
                            VStack {
                                Divider()
                                HStack {
                                    Text(value)
                                    Spacer()
                                    Text("10")
                                    Image(systemName: "chevron.right")
                                }
                            }
                        })
                    }
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Review")
                    ForEach(0..<10) { _ in
                        Divider()
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                            VStack {
                                HStack(alignment: .firstTextBaseline) {
                                    VStack {
                                        Text("Ellen McLaughlin")
                                            .bold(size: 15)
                                        Text("2 hours ago")
                                            .regular(size: 12)
                                    }
                                    HStack(spacing: 2) {
                                        ForEach(0..<5) { _ in
                                            Image(systemName: SFSymbols.starFill)
    //                                            .resizable()
                                                .frame(height: 16)
                                                .foregroundColor(.yellow)
                                                
                                        }
                                    }
                                }
                                Text("So we needed up ordering the deep fried salmon roll with Chinese hot mustard and wasabi noodles with salmon.")
                                    .regular(size: 15)
                            }
                        }
                        
                    }
                    Divider()
                }
                
                
            }
            .padding()
        }
    }
}

struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailsView()
    }
}
