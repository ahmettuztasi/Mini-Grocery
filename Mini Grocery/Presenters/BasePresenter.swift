//
//  BasePresenter.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import Foundation

class BasePresenter {
    public var products = Products()
    
    func increaseCartProduct(product: Product, index: IndexPath) {
        if let quantity = product.quantity {
            if quantity < product.stock {
                product.quantity = quantity + 1
            }
        }else {
            product.quantity = 1
        }
    }
    
    func decreaseCartProduct(product: Product, index: IndexPath) {
        if let quantity = product.quantity {
            if quantity > 0{
                product.quantity = quantity - 1
            }
        }
    }
}
