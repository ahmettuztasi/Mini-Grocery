//
//  ProductService.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import Foundation

class ProductListService {
    
    func getProducts(completion: @escaping (Products?, Error?) -> Void) {
        APIManager().setBaseUrl(url: HttpLink.list.UrlValue)
            .setMethod(method: .get)
            .sendRequest(completion: { (response) in
                switch response {
                case .success(let data):
                    do {
                        let products = try JSONDecoder().decode(Products.self, from: data)
                        completion(products, nil)
                    } catch {
                        completion(nil, error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            })
    }
}
