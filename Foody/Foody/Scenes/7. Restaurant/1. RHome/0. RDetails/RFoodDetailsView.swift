//
//  RFoodDetails.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import SwiftUI

struct RFoodDetailsView: View {
    @StateObject var viewModel = RProductDetailsViewModel()
    @State private var lineLimit: Int = 5
    @State private var isPresentedConfirmDelete: Bool = false
    @State private var isPresentedEditView: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(showsIndicators: false) {
                VStack {
                    if viewModel.product.imageUrls.isEmpty {
                        Image(nil)
                            .resizable()
                            .frame(maxWidth: kScreenSize.width, maxHeight: 358)
                            .scaledToFill()
                            .background(Color.red)
                    } else {
                        TabView {
                            ForEach(viewModel.product.imageUrls, id: \.self) { url in
                                SDImageView(url: url)
                                    .frame(maxWidth: kScreenSize.width, maxHeight: 358)
                                    .scaledToFill()
                                    .clipped()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(height: 358)
                    }
                    

                    VStack(alignment: .leading, spacing: 13) {
                        HStack {
                            Text(viewModel.product.name)
                                .font(.title)
                                .lineLimit(2)
                            
                            Image(systemName: SFSymbols.checkmarkCircleFill)
                                .resizable()
                                .frame(maxWidth: 20, maxHeight: 20)
                                .foregroundColor(viewModel.product.accepted ? .green: .gray)
                        }
                        
                        HStack(spacing: 3) {
                            Text("Description")
                                .font(.title3)
                            
                            Spacer()
                            
                            let voteCount = viewModel.product.voteCount
                            ForEach(0..<5) { index in
                                Image(systemName: SFSymbols.starFill)
                                    .resizable()
                                    .frame(maxWidth: 20 * scale, maxHeight: 20 * scale)
                                    .foregroundColor(voteCount > index ? .yellow: .gray)
                            }
                            Text(" \(voteCount) votes")
                                .font(.body)
                        }
                        .padding(.top, 10)
                        
                        Text(viewModel.product.descriptions)
                            .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                lineLimit = 0
                            }, label: {
                                Text("See more")
                                    .underline()
                            })
                        }
                        .opacity(lineLimit == 5
                                    && !viewModel.product.descriptions.isEmpty ? 1: 0)
                    }
                    .padding(.horizontal)
                                    
                    VStack {
                        Text("\(viewModel.product.price) VNĐ")
                            .font(.title2)
                        
                        if viewModel.action != .normal {
                            Button(action: {
                                viewModel.requestNewProduct()
                            }, label: {
                                ZStack {
                                    Text(viewModel.action == .preview ? "Add New Request": "Comtinue")
                                    
                                    HStack {
                                        Spacer()
                                        Image(systemName: SFSymbols.eject)
                                            .font(.title3)
                                            .padding(.trailing, 10)
                                    }
                                }
                                .regular(size: 17)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Colors.redColorCustom)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            })
                        }
                    }
                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20))
                    
                    if viewModel.action != .preview {
                        VStack(alignment: .leading) {
                            Group {
                                Divider()
                                Text("Reviews")
                                    .font(.title3)
                            }
                            .padding(.horizontal)
                            
                            List {
                                ForEach(viewModel.comments, id: \._id) { comment in
                                    CommentView(comment: comment)
                                }
                            }
                            .frame(height: viewModel.comments.isEmpty ? 150: 400)
                            .addEmptyView(isEmpty: viewModel.comments.isEmpty && !viewModel.isLoading, "No customer has commented yet!")
                        }
                    }
                }
                .regular(size: 15)
                .foregroundColor(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1).color)
            }
            .onRefresh {
                viewModel.getProductInfo()
            }
            
            HStack {
                BackButton(icon: .arrowLeft)
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.gray.opacity(0.4))
                    )
                
                Spacer()
                
                CircleButton(systemName: SFSymbols.squareAndPencil, color: .blue,
                             action: {
                                isPresentedEditView = true
                             }
                )
                .hidden(viewModel.action == .preview)
                
                CircleButton(systemName: SFSymbols.trashFill, color: .red,
                             action: {
                                isPresentedConfirmDelete = true
                             }
                )
                .hidden(viewModel.action == .preview)
            }
            .padding(20)
        }
        .handleAction(isActive: $viewModel.showSuccessPopup, action: {
            handleShowNotiPupup()
        })
        .navigationBarHidden(true)
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .onReceive(viewModel.$deleteSuccess, perform: { deleted in
            if deleted {
                topController?.navigationController?.popToRoot(withAnimation: .easeOut)
            }
        })
        .alert(isPresented: $isPresentedConfirmDelete, content: {
            Alert(title: Text("Delete product"),
                  message: Text("Are you sure you want to delete this product?"),
                  primaryButton: .destructive(Text("Delete"), action: {
                    deleteProduct()
                  }),
                  secondaryButton: .cancel()
            )
        })
        .fullScreenCover(isPresented: $isPresentedEditView, content: {
            RAddProductView(viewModel: viewModel.previewViewModel, isActive: $isPresentedEditView)
        })
        .navigationBarTitle(viewModel.action == .preview ? "Preview": "Details", displayMode: .inline)
        .ignoresSafeArea()
    }
}

extension RFoodDetailsView {
    func deleteProduct() {
        viewModel.deleteProduct()
    }
    
    func handleShowNotiPupup() {
        presentView(
            AlertView(.constant(
                    PopupContent(
                        message: "Congratulations, your request for a new product has been created. Waiting for admin approval. Thanks!",
                        title: "Preview",
                        action: {
                        topController?.navigationController?.popToRoot()
                    })
                )
            )
        )
    }
}

struct RFoodDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RFoodDetailsView()
        }
    }
}

