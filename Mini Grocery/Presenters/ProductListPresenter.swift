//
//  ProductListPresenter.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import Foundation

class ProductListPresenter: BasePresenter {
    
    private let productListService: ProductListService
    weak private var delegate: ProductListPresenterDelegate?
    
    init(productListService: ProductListService) {
        self.productListService = productListService
    }
    
    func setDelegate(delegate: ProductListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getProducts() {
        delegate?.startLoading()
        
        if !CartRepository.shared.cartProducts!.isEmpty {
            for cartProduct in CartRepository.shared.cartProducts! {
                for product in products {
                    if product.id == cartProduct.id {
                        product.quantity = cartProduct.quantity
                        break
                    }
                }
            }
            
            self.delegate?.setProducts()
            self.delegate?.finishLoading()
        }else {
            productListService.getProducts(completion: { (products, error) in
                if let products = products {
                    self.products = products
                    self.delegate?.setProducts()
                    self.delegate?.finishLoading()
                    self.calculateCartBadgeNumber()
                }else {
                    self.delegate?.finishLoading()
                    self.delegate?.error(error: error!)
                }
            })
        }
        
        calculateCartBadgeNumber()
    }
    
    func setCartProducts() {
        CartRepository.shared.cartProducts = products.filter({$0.quantity ?? 0 > 0})
    }
    
    override func increaseCartProduct(product: Product, index: IndexPath) {
        super.increaseCartProduct(product: product, index: index)
        delegate?.setQuantity(index: index, qty: product.quantity!)
        calculateCartBadgeNumber()
    }
    
    override func decreaseCartProduct(product: Product, index: IndexPath) {
        super.decreaseCartProduct(product: product, index: index)
        delegate?.setQuantity(index: index, qty: product.quantity!)
        calculateCartBadgeNumber()
    }
    
    func calculateCartBadgeNumber() {
        var badgeNumber = 0
        for product in products {
            if let qty = product.quantity {
                badgeNumber = badgeNumber + qty
            }
        }
        delegate?.setCartBadge(productCount: badgeNumber)
    }
}

protocol ProductListPresenterDelegate: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setProducts()
    func setCartBadge(productCount: Int)
    func setQuantity(index: IndexPath, qty: Int)
    func error(error: Error)
}
