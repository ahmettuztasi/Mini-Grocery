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
                self.delegate?.finishLoading()
            }else {
                self.delegate?.finishLoading()
                self.delegate?.error(error: error!)
            }
        })
    }
    
    func clearCart(){
        products.removeAll()
        CartRepository.shared.cartProducts?.removeAll()
        delegate?.setCartProducts()
    }
    
    func isEmptyCart() -> Bool {
        if products.isEmpty {
            return true
        }else {
            return false
        }
    }
    
    func calculateTotalPrice() {
        var totalPrice = 0.0
        for product in products {
            totalPrice += (Double(product.price) * Double(product.quantity ?? 0))
        }
        delegate?.setTotalPrice(totalPrice: totalPrice, currency: "₺")
    }
    
    override func increaseCartProduct(product: Product, index: IndexPath) {
        super.increaseCartProduct(product: product, index: index)
        delegate?.setQuantity(index: index, qty: product.quantity!)
        calculateTotalPrice()
    }
    
    override func decreaseCartProduct(product: Product, index: IndexPath) {
        super.decreaseCartProduct(product: product, index: index)
        delegate?.setQuantity(index: index, qty: product.quantity!)
        if let qty = product.quantity {
            if qty == 0 {
                products.remove(at: index.row)
                CartRepository.shared.cartProducts?.remove(at: index.row)
                delegate?.deleteRow(index: index)
            }
        }
        calculateTotalPrice()
    }
    
    func prepareQuantity(index: IndexPath) {
        products.remove(at: index.row)
        CartRepository.shared.cartProducts?.remove(at: index.row)
    }
}

protocol CartPresenterDelegate: NSObjectProtocol {
    func setQuantity(index: IndexPath, qty: Int)
    func startLoading()
    func finishLoading()
    func checkoutResponse(checkout: Checkout)
    func setTotalPrice(totalPrice: Double, currency: String)
    func setCartProducts()
    func deleteRow(index: IndexPath)
    func error(error: Error)
}
