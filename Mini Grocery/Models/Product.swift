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

    enum CodingKeys: String, CodingKey {
        case id, name, price, currency
        case imageURL = "imageUrl"
        case stock
    }

    init(id: String, name: String, price: Double, currency: String, imageURL: String, stock: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.currency = currency
        self.imageURL = imageURL
        self.stock = stock
    }
}

typealias Products = [Product]
