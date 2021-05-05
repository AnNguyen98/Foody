//
//  FoodDetails.swift
//  Foody
//
//  Created by An Nguyễn on 2/27/21.
//

import SwiftUI

struct FoodDetailsView: View {
    @State private var numberOfItems: Int = 0
    @State private var checkItems: [Int] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack(alignment: .top) {
                    TabView {
                        ForEach(0..<5) { _ in
                            Image("food_img_details")
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 358)
                    HStack {
                        Spacer()
                        
                        CircleButton(systemName: "square.and.arrow.up", color: .black,
                                     action: { })
                        
                        CircleButton(systemName: "star.fill", color: .red,
                                     action: { })
                    }
                    .padding()
                }
                

                VStack(alignment: .leading, spacing: 5) {
                    Text("California Roll with Black Sesame")
                        .regular(size: 30)
                        .lineLimit(2)
                        .layoutPriority(1000)
                        
                    
                    HStack {
                        Text("Description")
                            .bold(size: 17)
                            .padding(.top, 10)
                        Spacer()
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        Text("(votes)")
                            .regular(size: 13)
                    }
                    
                    Text("It is often frustrating to attempt to plan meals that are designed for one. Despite this fact, we are seeing more and more recipe books and Internet websites that are dedicated to the act of cooking for one. Despite this fact, we are seeing more and more recipe books and Internet websites that are dedicated to the act of cooking for one. ")
                        .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                    
                    Text("Extras")
                        .bold(size: 17)
                        .padding(.top, 20)
                    
                    VStack(alignment: .leading) {
                        ForEach(0..<10) { value in
                            Divider()
                            Button(action: {
                                if checkItems.contains(value) {
                                    checkItems.removeAll(where: { $0 == value })
                                } else {
                                    checkItems.append(value)
                                }
                            }, label: {
                                HStack {
                                    Text("Tuna \(value)")
                                    Text("+$35.00")
                                        .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                        .foregroundColor(checkItems.contains(value) ? Colors.redColorCustom: .clear)
                                }
                            })
                            
                        }
                        Divider()
                    }
                    
                    Group {
                        Text("Quantity")
                            .bold(size: 17)
                            .padding(.top, 20)

                        Stepper(value: $numberOfItems, in: 1...50) {
                            Text("\(numberOfItems) items")
                        }
                    }
                }
                .padding(.horizontal)
                                
                VStack {
                    Text("$49.50")
                        .bold(size: 20)
                    
                    Button(action: {}, label: {
                        ZStack {
                            Text("Add to order")
                            HStack {
                                Spacer()
                                Image(systemName: "creditcard")
                                    .font(.title3)
                                    .padding(.trailing, 10)
                            }
                        }
                        .regular(size: 17)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Colors.redColorCustom)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    })
                }
                .padding(EdgeInsets(top: 50, leading: 20, bottom: 20, trailing: 20))
                
                VStack(alignment: .leading) {
                    Group {
                        Divider()
                        Text("Reviews")
                            .bold(size: 17)
                    }
                    .padding(.horizontal)
                    
                    List {
                        ForEach(0..<10) { _ in
                            CommentView()
                        }
                    }
                    .frame(height: 400)
                }
            }
            .regular(size: 15)
            .foregroundColor(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1).color)
        }
        .ignoresSafeArea()
    }
}

struct FoodDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailsView()
    }
}
