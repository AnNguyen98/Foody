//
//  RAddProductView.swift
//  Foody
//
//  Created by MBA0283F on 5/19/21.
//

import SwiftUI
import SwiftUIX
import Introspect

struct RAddProductView: View {
    @StateObject private var viewModel = RAddProductViewModel()
    @State private var isPresentedPickerView = false
    @State private var isPresentedProductDetails = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                NavigationLink(
                    destination: RFoodDetailsView(viewModel: viewModel.previewDetailViewModel),
                    isActive: $isPresentedProductDetails,
                    label: {  EmptyView() }
                )
                
                if viewModel.images.isEmpty {
                    Image("default-thumbnail")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(15)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(0..<viewModel.images.count, id: \.self) { index in
                                ZStack(alignment: .topLeading) {
                                    Image(uiImage: viewModel.images[index])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: kScreenSize.width - 30, maxHeight: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .padding(.horizontal, 15)
                                    
                                    ZStack {
                                        Circle()
                                            .foregroundColor(Color.gray.opacity(0.7))
                                        
                                        Text("\(index + 1)")
                                            .font(.body)
                                            .bold()
                                            .foregroundColor(.white)
                                            
                                    }
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 30)
                                    .padding(.top, 15)
                                }
                            }
                        }
                    }
                    .introspectScrollView { (scrollView) in
                        scrollView.isPagingEnabled = true
                    }
                    .padding(.top, 15)
                }
                
                
                VStack {
                    HStack {
                        Text("Choose images:")
                        
                        Text("\(viewModel.images.count)")
                            .bold()
                            .underline()
                            .foregroundColor(.blue)
                            .font(.body)
                        
                        Spacer()
                        
                        Button(action: {
                            isPresentedPickerView.toggle()
                        }, label: {
                            Image(systemName: SFSymbols.cameraCircleFill)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        })
                        .padding(.trailing)
                    }
                    
                    TextField("Product name...", text: $viewModel.productName)
                        .frame(maxWidth: .infinity, minHeight: 46)
                        .padding(.horizontal)
                        .border(cornerRadius: 23)
                    
                    TextField("Price...", text: $viewModel.price)
                        .frame(maxWidth: .infinity, minHeight: 46)
                        .padding(.horizontal)
                        .border(cornerRadius: 46 / 2)
                        .keyboardType(.numberPad)
                    
                    TextView("Description...", text: $viewModel.description)
                        .frame(maxWidth: .infinity, minHeight: 150)
                        .padding()
                        .border(cornerRadius: 15)
                    
                    
                    HStack {
                        Text("Type: ")
                        
                        Spacer()
                        
                        RadioButton(isSelected: $viewModel.isDrinkSelected, action: {
                            viewModel.isDrinkSelected = true
                        }, content: {
                            Text("Drink")
                        })

                        RadioButton(isSelected: .constant(!viewModel.isDrinkSelected), action: {
                            viewModel.isDrinkSelected = false
                        }, content: {
                            Text("Food")
                        })
                    }
                    
                    Button(action: {
                        isPresentedProductDetails.toggle()
                    }, label: {
                        Text("Preview")
                            .bold(size: 18)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)).opacity(viewModel.inValidInfo ? 0.5: 0.9))
                            .foregroundColor(Color.white.opacity(viewModel.inValidInfo ? 0.5: 1))
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.vertical, 30)
                    .disabled(viewModel.inValidInfo)
                }
                .padding(.horizontal, 15)
            }
        }
        .navigationTitle(Text("New Product"))
        .handleHidenKeyboard()
        .fullScreenCover(isPresented: $isPresentedPickerView, content: {
            ImagePickerView(images: $viewModel.images)
                .ignoresSafeArea()
        })
        .foregroundColor(.black)
        .setupNavigationBar()
        .setupBackgroundNavigationBar()
        .statusBarStyle(.lightContent)
    }
}

struct RAddProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RAddProductView()
        }
    }
}
