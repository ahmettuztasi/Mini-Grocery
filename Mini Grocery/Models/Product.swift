//
//  Product.swift
//  Mini Grocery
//
//  Created by ahmet on 12.12.2020.
//

import Foundation

// MARK: - Product
class Product: Codable {
    let id, name: String?
    let price: Double?
    let currency: String?
    let imageURL: String?
    let stock: Int?
    let amount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, price, currency, amount
        case imageURL = "imageUrl"
        case stock
    }

    init(id: String, name: String, price: Double, currency: String, imageURL: String, stock: Int, amount: Int? = 0) {
        self.id = id
        self.name = name
        self.price = price
        self.currency = currency
        self.imageURL = imageURL
        self.stock = stock
        self.amount = amount
    }
}

typealias Products = [Product]
