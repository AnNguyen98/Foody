//
//  FoodDetails.swift
//  Foody
//
//  Created by An Nguyễn on 2/27/21.
//

import SwiftUI
import SwiftUIX

struct FoodDetailsView: View {
    @StateObject var viewModel = ProductDetailsViewModel()
    @State private var product: Product?
    @State private var isPresentedAppActivityView = false
    @State private var isPresentedOrderView = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            NavigationLink(destination: OrderView(viewModel: viewModel.orderViewModel),
                           isActive: $isPresentedOrderView, label: {
                                EmptyView()
                           })
            VStack {
                ZStack(alignment: .top) {
                    if viewModel.product.productImages.isEmpty {
                        Image(nil)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: kScreenSize.width, minHeight: 358)
                    } else {
                        TabView {
                            ForEach(viewModel.product.productImages, id: \.self) { data in
                                Image(data)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: kScreenSize.width, minHeight: 358)
                                    .clipped()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(maxWidth: kScreenSize.width, minHeight: 358)
                    }
                    
                    HStack {
                        Spacer()
                        
                        CircleButton(systemName: SFSymbols.squareAndArrowUp, color: .black,
                                     action: {
                                        isPresentedAppActivityView = true
                                     })
                        
                        CircleButton(systemName: SFSymbols.starFill, color: viewModel.product.isLiked ? .red: .gray,
                                     action: {
                                        if viewModel.product.isLiked {
                                            self.product = viewModel.product
                                        } else {
                                            viewModel.addToFavorite(viewModel.product)
                                        }
                                     })
                    }
                    .padding(30)
                }
                

                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.product.name)
                        .bold(size: 30)
                        .lineLimit(2)
                    
                    Text(viewModel.product.restaurantName)
                        .foregroundColor(.gray)
                        .font(.title3)
                    
                    Text(viewModel.product.address)
                        .font(.body)
                        .foregroundColor(.red)
                    
                    HStack(spacing: 3) {
                        Text("Description")
                            .font(.title3)
                        
                        Spacer()
                        
                        let voteCount = viewModel.product.voteCount
                        ForEach(0..<5) { index in
                            Image(systemName: SFSymbols.starFill)
                                .resizable()
                                .frame(width: 20 * scale, height: 20 * scale)
                                .foregroundColor(voteCount > index ? .yellow: .gray)
                                .onTapGesture {
                                    if voteCount != index + 1 {
                                        viewModel.voteProduct(vote: index + 1)
                                    }
                                }
                        }
                        Text(" \(voteCount) votes")
                            .font(.body)
                    }
                    .padding(.top, 10)
                    
                    Text(viewModel.product.descriptions)
                        .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                .padding(.horizontal)
                                
                VStack {
                    Text("\(viewModel.product.price) VNĐ")
                        .bold(size: 20)
                    
                    Button(action: {
                        isPresentedOrderView.toggle()
                    }, label: {
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
                        .padding(.top, 30)
                        
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
                    .frame(height: viewModel.comments.isEmpty ? 0: 400)
                }
                .hidden(viewModel.comments.isEmpty)
                .padding(.bottom, viewModel.comments.isEmpty ? 0: 30)
            }
            .regular(size: 15)
            .foregroundColor(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1).color)
        }
        .ignoresSafeArea()
        .addBackBarCustom()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .alert(item: $product, content: { product in
            Alert(title: Text("Delete favorite"),
                  message: Text("Are you want to delete this item in your favorites?"),
                  primaryButton: .destructive(Text("Delete"), action: {
                    viewModel.deleteInFavorite(product)
                  }),
                  secondaryButton: .cancel()
            )
        })
        .popover(isPresented: $isPresentedAppActivityView, content: {
            AppActivityView(activityItems: [viewModel.product.name + " - " + viewModel.product.price.string + " vnđ"])
        })
    }
}

struct FoodDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailsView()
    }
}
