//
//  ProductListViewController.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import UIKit

class ProductListViewController: UICollectionViewController {
    private let productListPresenter = ProductListPresenter(productListService: ProductListService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        productListPresenter.setDelegate(delegate: self)
        productListPresenter.getProducts()
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ProductListViewController: ProductListPresenterDelegate {
    func setToCart(productId: String, amount: Int, info: String) {
        print(productId)
    }
    
    func setCartBadge(productCount: Int) {
        print(productCount)
    }
    
    func startLoading() {
        print("startLoading")
    }
    
    func finishLoading() {
        print("finishLoading")
    }
    
    func setProducts(products: Products) {
        print(products)
    }
    
    func error(error: Error) {
        print(error)
    }
}
