//
//  ROrdersView.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import SwiftUI
import SwiftUIX

struct ROrdersView: View {
    @StateObject private var viewModel = ROrdersViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Picker("orders", selection: $viewModel.selectedIndex, content: {
                    Text("Processing").tag(0)
                    Text("Canceled").tag(1)
                    Text("Shipping").tag(2)
                    Text("Payment").tag(3)
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding([.top, .horizontal], 10)
                
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.currentOrders, id: \._id) { order in
                        VStack(spacing: 0) {
                            HStack {
                                Image("no-user")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                    .shadow(radius: 2)
                                
                                VStack(alignment: .leading) {
                                    Text(order.username)
                                    
                                    Text(order.orderTime)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("Total: \(order.count)")
                                    .font(.body)
                            }
                            
                            Divider()
                                .padding(.vertical, 10)
                            
                            HStack(spacing: 10) {
                                Image(order.product.productImages.first)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(order.product.name)
                                            .font(.title2)
                                    }
                                    
                                    HStack {
                                        Text("Price:")
                                        Text("\(order.product.price) vnđ")
                                            .foregroundColor(.blue)
                                    }
                                    .font(.body)
                                    
                                    Text("Address: \(order.address)")
                                    
                                    HStack {
                                        Text("Phone:")
                                        Text(order.phoneNumber)
                                            .underline()
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                callPhoneNumber(phoneNumber: order.phoneNumber)
                                            }
                                    }
                                    
                                    Text("ID: \(order._id)")
                                        .foregroundColor(.gray)
                                    
                                    HStack {
                                        Spacer()
                                        
                                        CircleButton(systemName: SFSymbols.xmark, color: .red,
                                                     action: {
                                                        cancelOrder(order)
                                                     })
                                        
                                        CircleButton(systemName: SFSymbols.checkmark, color: .green,
                                                     action: {
                                                        verifyOrder(order)
                                                     })
                                    }
                                }
                            }
                        }
                        .font(.caption)
                        .padding(10)
                        .lineLimit(1)
                        .frame(maxWidth: kScreenSize.width)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .gray, radius: 3)
                        .onTapGesture {
                            print("OKKK")
                        }
                    }
                    
                }
                .prepareForLoadMore(loadMore: {
                    
                }, showIndicator: false)
                .onRefresh {
                    viewModel.getOrders()
                }
            }
            .navigationSearchBar({
                SearchBar("Enter id of order...", text: $viewModel.searchText)
                    .showsCancelButton(true)
                    .searchBarStyle(.default)
                    .returnKeyType(.search)
            })
            .navigationBarTitle("Orders", displayMode: .inline)
            .setupNavigationBar()
            .setupBackgroundNavigationBar()
            .addLoadingIcon($viewModel.isLoading)
            .handleErrors($viewModel.error)
            
            FloatButtonView()
        }
    }
}

extension ROrdersView {
    private func cancelOrder(_ order: Order) {
        viewModel.verifySendingOrder(order: order, status: .canceled)
    }
    
    private func verifyOrder(_ order: Order) {
        viewModel.verifySendingOrder(order: order, status: .shipping)
    }
    
    private func callPhoneNumber(phoneNumber: String) {
        var phone = phoneNumber
        phone.removeAll(where: { "\($0)".elementsEqual("-") || "\($0)".elementsEqual(" ") })
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else {
            viewModel.error = .unknow("Can't open url!")
        }
    }
}

struct ROrdersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ROrdersView()
        }
    }
}
