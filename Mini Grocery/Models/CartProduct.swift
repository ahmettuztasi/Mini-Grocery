//
//  CartProduct.swift
//  Mini Grocery
//
//  Created by ahmet on 12.12.2020.
//

import Foundation

// MARK: - CartProduct
class CartProduct: Codable {
    let id: String?
    let amount: Int?

    init(id: String, amount: Int) {
        self.id = id
        self.amount = amount
    }
}

typealias CartProducts = [CartProduct]
