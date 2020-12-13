//
//  CartService.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import Foundation

class CartService {
    
    func checkOutCart(cartProducts: Products, completion: @escaping (Checkout?, Error?) -> Void) {
        let dict = [ "products": cartProducts.map({["id": $0.id, "amount": $0.quantity!]}) ]
        
        APIManager().setBaseUrl(url: HttpLink.checkout.UrlValue)
            .setMethod(method: .post)
            .setParameters(parameters: dict)
            .sendRequest(completion: { (response) in
                switch response {
                case .success(let data):
                    do {
                        let checkout = try JSONDecoder().decode(Checkout.self, from: data)
                        completion(checkout,nil)
                    } catch {
                        completion(nil,error)
                    }
                case .failure(let error):
                    completion(nil,error)
                }
            })
    }
}
