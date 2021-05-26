//
//  RestaurantView.swift
//  Foody
//
//  Created by An Nguyễn on 2/27/21.
//

import SwiftUI

struct RestaurantDetailsView: View {
    @StateObject var viewModel = RestaurantDetailsViewModel()
        
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(viewModel.restaurant.name)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)
                
                Text(viewModel.restaurant.address)
                
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
                        Text(viewModel.restaurant.openTime)
                            .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                    }
                }
                
                Group {
                    Divider()
                    HStack {
                        CircleButton(systemName:  SFSymbols.squareAndArrowUp, color: .black,
                                     action: { })
                        
                        CircleButton(systemName: SFSymbols.phoneFill, color: .black,
                                     action: { })
                        
                        CircleButton(systemName: SFSymbols.location, color: .black,
                                     action: { })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
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
                
                HStack {
                    Text("Feature items:")
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            Text("See more")
                        }
                    )
                    .disabled(true)
                }
                .padding(.vertical, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(viewModel.products, id: \.self) { product in
                            VStack(alignment: .leading) {
                                Image(product.productImages.first)
                                    .resizable()
                                    .frame(width: kScreenSize.width * 343 / 380, height: 160)
                                    .clipped()
                                
                                Text(product.name)
                                    .bold()
                                    .padding(.horizontal)
                                
                                Text("\(product.price) VNĐ")
                                    .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                                    .padding(.horizontal)
                            }
                            .font(.body)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .gray, radius: 2, x: 0.0, y: 0)
                        }
                    }
                    .padding(.vertical)
                }
                .frame(maxWidth: kScreenSize.width, minHeight: 160)
                .addEmptyView(isEmpty: viewModel.products.isEmpty && !viewModel.isLoading)
            }
            .padding()
        }
        .setupNavigationBar()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .navigationBarBackButton()
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}

struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailsView()
        }
    }
}
