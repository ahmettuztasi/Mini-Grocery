//
//  CartPresenter.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import Foundation

class CartPresenter: BasePresenter {
    private let cartService: CartService
    weak private var delegate: CartPresenterDelegate?
    
    init(cartService: CartService) {
        self.cartService = cartService
    }
    
    func setDelegate(delegate: CartPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getCartProducts() {
        if let cartProducts = CartRepository.shared.cartProducts {
            for product in cartProducts {
                if let qty = product.quantity {
                    if qty > 0 {
                        self.products.append(product)
                    }
                }
            }
            delegate?.setCartProducts()
        }
    }
    
    func checkOut() {
        delegate?.startLoading()
        
        cartService.checkOutCart(cartProducts: products, completion: { (checkout, error) in
            if let checkout = checkout {
                self.delegate?.checkoutResponse(checkout: checkout)
            }else {
                self.delegate?.finishLoading()
                self.delegate?.error(error: error!)
            }
        })
    }
    
    func clearCart() {
        
    }
    
    func calculateTotalPrice() {
        var totalPrice = 0
        for product in products {
            totalPrice += Int(product.price )
        }
        delegate?.setTotalPrice(totalPrice: totalPrice, currency: "₺")
    }
}

protocol CartPresenterDelegate: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func checkoutResponse(checkout: Checkout)
    func setToCart(productId: String, amount: Int, info: String)
    func setTotalPrice(totalPrice: Int, currency: String)
    func setCartProducts()
    func error(error: Error)
}
