//
//  CartViewController.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import UIKit

class CartViewController: UITableViewController {
    private let cartPresenter = CartPresenter(cartService: CartService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        cartPresenter.setDelegate(delegate: self)
        
        cartPresenter.checkOut()
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension CartViewController: CartPresenterDelegate {
    func setTotalPrice(totalPrice: Int) {
        print(totalPrice)
    }
    
    func setToCart(productId: String, amount: Int, info: String) {
        print(info)
    }
    
    func checkoutResponse(checkout: Checkout) {
        print(checkout)
    }
    
    func startLoading() {
        print("startLoading")
    }
    
    func finishLoading() {
        print("finishLoading")
    }
    
    func error(error: Error) {
        print(error)
    }
}
