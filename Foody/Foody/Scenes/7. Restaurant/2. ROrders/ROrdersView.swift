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
    @State private var isPresentedUserDetail = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 5) {
                if !viewModel.isSearching {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Picker("orders", selection: $viewModel.selectedIndex, content: {
                                Text("Pending").tag(0)
                                Text("Processing").tag(1)
                                Text("Canceled").tag(2)
                                Text("Shipping").tag(3)
                                Text("Payment").tag(4)
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            .padding([.top, .horizontal], 10)
                        }
                        .frame(width: kScreenSize.width + 60, height: 50)
                    }
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
                                NavigationLink(destination: ProfileView(viewModel: viewModel.profileViewModel(order.userId)),
                                               isActive: $isPresentedUserDetail, label: {
                                                    EmptyView()
                                               })
                                SDImageView(url: order.userProfile, isProfile: true)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                    .shadow(radius: 2)
                                    .onTapGesture {
                                        isPresentedUserDetail = true
                                    }
                                    
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
                                        
                                        if order.isCanceled {
                                            Image(systemName: order.canceledByUser ? SFSymbols.person: SFSymbols.house)
                                        }
                                        
                                        Text(order.time)
                                            .font(.caption2)
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
                                    
                                    if !order.paymented, !order.isCanceled {
                                        HStack {
                                            Spacer()
                                            
                                            CircleButton(systemName: SFSymbols.xmark, color: .red,
                                                         action: {
                                                            viewModel.cureentOrder = order
                                                         }
                                            )
                                            .hidden(order.isShipping)
                                            
                                            CircleButton(systemName: SFSymbols.checkmark, color: .green,
                                                         action: {
                                                            if order.isPending {
                                                                viewModel.verifyOrder(order: order, status: .processing)
                                                            } else if order.isProcessing {
                                                                viewModel.verifyOrder(order: order, status: .shipping)
                                                            } else if order.isShipping {
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
                Alert(title: Text("\(order.isProcessing ? "Pending": "Cancel") order"),
                      message: Text("Do you want \(order.isProcessing ? "move this order to pending": "to cancel this order")?"),
                      primaryButton: .destructive(Text("Continue"), action: {
                        viewModel.verifyOrder(order: order, status: order.isProcessing ? .pending: .canceled)
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
