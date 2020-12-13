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
        configureNavBar()
        
        cartPresenter.setDelegate(delegate: self)
        cartPresenter.checkOut()
    }
    
    func configureNavBar() {
        self.navigationItem.title = "Sepet"
        let closeButton = UIBarButtonItem(title: "Kapat", style: .plain, target: self, action: #selector(closeBtnTapped))
        
        let clearButton = UIBarButtonItem(title: "Sil", style: .plain, target: self, action: nil)
        clearButton.tintColor = .red
        self.navigationItem.rightBarButtonItem = closeButton
        self.navigationItem.leftBarButtonItem = clearButton
    }
    
    @objc func closeBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

//Table View
extension CartViewController {
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell")!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//Presenter Callbacks
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
