//
//  OrderView.swift
//  Foody
//
//  Created by MBA0283F on 5/10/21.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Địa chỉ nhận hàng")
                Button(action: {}, label: {
                    Text("Thay đổi")
                })
            }
            
            Text("An Nguyen - 0399837373")
            Text("264 Tôn Đản, Phường Hoà An, Quận Cẩm Lệ, Đà Nẵng")
            
            VStack {
                Text("Đơn hàng sẽ được giao một lần")
                Text("Giao trước 10:00 ngày mai")
                Text("Được giao bời Tiki(từ Đà Nẵng)")
                
                HStack {
                    Image("food-1")
                    
                    VStack {
                        Text("Nồi chiên không dầu điện tử...")
                        
                        HStack {
                            Text("Số lượng: x1")
                            
                            HStack {
                                Text("2.689.000")
                                
                                Text(" đ")
                                    .underline()
                            }
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text("Tạm tính")
                        Text("Tạm tính")
                    }
                    
                    HStack {
                        Text("Phí vận chuyển")
                        Text("90.000 đ")
                    }
                }
                
                HStack {
                    Text("Thành tiền")
                    Text("20.000đ")
                        .bold()
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    
                }, label: {
                    Text("Tiến hành đặt hàng")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                })
            }
        }
        .font(.body)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrderView()
        }
    }
}
