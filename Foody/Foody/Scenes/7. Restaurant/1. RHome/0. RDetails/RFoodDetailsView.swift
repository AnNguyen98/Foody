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
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack(alignment: .top) {
                    if !viewModel.images.isEmpty {
                        TabView {
                            ForEach(viewModel.images, id: \.self) { data in
                                Image(data)
                                    .resizable()
                                    .frame(maxWidth: kScreenSize.width, maxHeight: 358)
                                    .scaledToFit()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(height: 358)
                    }
                    
                    if viewModel.action != .preview {
                        HStack {
                            Spacer()
                            
                            CircleButton(systemName: SFSymbols.squareAndPencil, color: .blue,
                                         action: {
                                            isPresentedEditView = true
                                         })
                            
                            CircleButton(systemName: SFSymbols.trashFill, color: .red,
                                         action: {
                                            isPresentedConfirmDelete = true
                                         })
                        }
                        .padding()
                    }
                }
                

                VStack(alignment: .leading, spacing: 13) {
                    Text(viewModel.product.name)
                        .font(.title)
                        .lineLimit(2)
                    
                    HStack(spacing: 3) {
                        Text("Description")
                            .font(.title3)
                        
                        Image(systemName: SFSymbols.checkmarkCircleFill)
                            .foregroundColor(viewModel.product.accepted ? .green: .gray)
                        
                        Spacer()
                        
                        let voteCount = viewModel.product.voteCount
                        ForEach(0..<5) { index in
                            Image(systemName: SFSymbols.starFill)
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
                    Text("\(viewModel.product.price) vnđ")
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
                                CommentView()
                            }
                        }
                        .frame(height: 400)
                        
                        
                    }
                }
            }
            .regular(size: 15)
            .foregroundColor(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1).color)
        }
        .onRefresh {
            viewModel.getProductInfo()
        }
        .handleAction(isActive: $viewModel.showSuccessPopup, action: {
            handleShowNotiPupup()
        })
        .addBackBarCustom()
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
            RAddProductView(isActive: $isPresentedEditView)
        })
        .setupNavigationBar()
        .navigationBarTitle(Text("Details"), displayMode: .inline)
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
        RFoodDetailsView()
    }
}

