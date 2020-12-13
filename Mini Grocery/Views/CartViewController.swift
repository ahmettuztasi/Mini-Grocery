//
//  CartViewController.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import UIKit

class CartViewController: UIViewController {
    public let cartPresenter = CartPresenter(cartService: CartService())
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavBar()
        
        cartPresenter.setDelegate(delegate: self)
        cartPresenter.getCartProducts()
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
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        cartPresenter.checkOut()
    }
    
}

//Table View
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartPresenter.products.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        cell.setupCell(cartProduct: cartPresenter.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        cell.prepareForReuse()
    }
}

//Presenter Callbacks
extension CartViewController: CartPresenterDelegate {
    func setCartProducts() {
        cartPresenter.calculateTotalPrice()
        tableView.reloadData()
    }
    
    func setTotalPrice(totalPrice: Int, currency: String) {
        self.totalPriceLabel.text = currency + String(totalPrice)
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
