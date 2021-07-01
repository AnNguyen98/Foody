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
    @State private var isActiveDetails = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 5) {
                if !viewModel.isSearching {
                    Picker("orders", selection: $viewModel.selectedIndex, content: {
                        Text("Processing").tag(0)
                        Text("Canceled").tag(1)
                        Text("Shipping").tag(2)
                        Text("Payment").tag(3)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.top, .horizontal], 10)
                } else {
                    HStack {
                        Text("Total result: \(viewModel.currentOrders.count)")
                            .padding([.top, .horizontal] ,15)
                        
                        Spacer()
                    }
                }
                
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.currentOrders, id: \._id) { order in
                        VStack(spacing: 0) {
                            NavigationLink(destination: RFoodDetailsView(viewModel: viewModel.detailsViewModel(order)),
                                           isActive: $isActiveDetails, label: {
                                                EmptyView()
                                           })
                            
                            HStack {
                                SDImageView(url: order.userProfile, isProfile: true)
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
                                SDImageView(url: order.product.imageUrls.first)
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
                                    
                                    if !order.paymented {
                                        HStack {
                                            Spacer()
                                            
                                            CircleButton(systemName: SFSymbols.xmark, color: .red,
                                                         action: {
                                                            viewModel.cureentOrder = order
                                                         }
                                            )
                                            .hidden(order.isCanceled)
                                            
                                            CircleButton(systemName: SFSymbols.checkmark, color: .green,
                                                         action: {
                                                            if order.isProcessing || order.isCanceled {
                                                                viewModel.verifyOrder(order: order, status: .shipping)
                                                            } else if order.shipping {
                                                                viewModel.verifyOrder(order: order, status: .paymented)
                                                            }
                                                         }
                                            )
                                        }
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
                            isActiveDetails.toggle()
                        }
                    }
                }
                .prepareForLoadMore(loadMore: {
                    
                }, showIndicator: false)
    //                .onRefresh {
    //                    viewModel.getOrders()
    //                }
                .addEmptyView(isEmpty: viewModel.currentOrders.isEmpty && !viewModel.isLoading, "Orders is empty.")
            }
            .navigationSearchBar({
                SearchBar("Search by ID", text: $viewModel.searchText)
                    .showsCancelButton(true)
                    .searchBarStyle(.default)
                    .returnKeyType(.search)
                    .onCancel {
                        viewModel.searchText = ""
                    }
            })
            .alert(item: $viewModel.cureentOrder) { (order) -> Alert in
                Alert(title: Text("Cancel order"),
                      message: Text("Do you want to cancel this order?"),
                      primaryButton: .destructive(Text("Continue"), action: {
                        viewModel.verifyOrder(order: order, status: .canceled)
                      }),
                      secondaryButton: .cancel()
                )
            }
            .navigationBarTitle("Orders", displayMode: .inline)
            .setupNavigationBar()
            .addLoadingIcon($viewModel.isLoading)
            .handleErrors($viewModel.error)
            
            FloatButtonView()
        }
    }
}

extension ROrdersView {
    private func callPhoneNumber(phoneNumber: String) {
        var phone = phoneNumber
        phone.removeAll(where: { "\($0)".elementsEqual("-") || "\($0)".elementsEqual(" ") })
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else {
            viewModel.error = .unknown("Can't open url!")
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
