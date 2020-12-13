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
        
        productListService.getProducts(completion: { (products, error) in
            if let products = products {
                self.delegate?.setProducts(products: products)
            }else {
                self.delegate?.finishLoading()
                self.delegate?.error(error: error!)
            }
        })
    }
}

protocol ProductListPresenterDelegate: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setProducts(products: Products)
    func setCartBadge(productCount: Int)
    func setToCart(productId: String, amount: Int, info: String)
    func error(error: Error)
}
