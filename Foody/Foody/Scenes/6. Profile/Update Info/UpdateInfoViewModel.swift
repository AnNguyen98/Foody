//
//  UpdateInfoViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/23/21.
//

import SwiftUI

final class UpdateInfoViewModel: ViewModel, ObservableObject {
    @Published var username: String = ""
    @Published var address: String = ""
    @Published var description: String = ""
    @Published var age: String = ""
    @Published var images: [UIImage] = []
    @Published var isUpdated: Bool = false
    @Published var isMale: Bool = false
    
    var inValidInfo: Bool {
        username.isEmpty || address.isEmpty || age.isEmpty
    }
    
    var user: User {
        Session.shared.user ?? User()
    }
    
    var restaurant: Restaurant {
        Session.shared.restaurant ?? Restaurant()
    }
    
    override init() {
        super.init()
        
        username = user.username
        address = user.address
        age = user.age.string
        isMale = user.gender
        address = user.address
        images = [user.imageProfile].compactMap({ $0 }) .compactMap({ UIImage(data: $0)})
        
        description = restaurant.descriptions
    }
    
    func updateInfo() {
        var params: Parameters = [
            "username"  : username,
            "address"   : address,
            "gender"    : isMale,
            "age"       : Int(age) ?? 0,
        ]
        
        if let image = images.first?.pngData()?.base64EncodedString() {
            params["imageProfileBase64"] = image
        }
        if !description.isEmpty {
            params["descriptions"] = description
        }
        
        isLoading = true
        AccountService.updateInfo(params)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                self.isUpdated = true
                Session.shared.user = res.user
                Session.shared.restaurant = res.restaurant
            }
            .store(in: &subscriptions)
    }
}
