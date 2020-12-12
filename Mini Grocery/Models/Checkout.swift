//
//  Checkout.swift
//  Mini Grocery
//
//  Created by ahmet on 12.12.2020.
//

import Foundation

// MARK: - Checkout
class Checkout: Codable {
    let orderID, message, error: String?

    init(orderID: String, message: String, error: String) {
        self.orderID = orderID
        self.message = message
        self.error = error
    }
}
