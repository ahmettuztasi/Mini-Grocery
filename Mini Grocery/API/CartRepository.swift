//
//  CartRepository.swift
//  Mini Grocery
//
//  Created by ahmet on 14.12.2020.
//

import Foundation

class CartRepository {
    static let shared = CartRepository()
    var cartProducts: Products?
    
    private init(){
        cartProducts = Products()
    }
}
