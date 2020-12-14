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
    
    var activityView: UIActivityIndicatorView?
    
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
        let clearButton = UIBarButtonItem(title: "Sil", style: .plain, target: self, action: #selector(clearCart))
        clearButton.tintColor = .red
        self.navigationItem.rightBarButtonItem = closeButton
        self.navigationItem.leftBarButtonItem = clearButton
    }
    
    @objc func closeBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clearCart() {
        if !cartPresenter.isEmptyCart() {
            let alert = UIAlertController(title: "Onay", message: "Sepetinizdeki ürünler silinecektir. İşleme devam etmek istiyor musunuz?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: {_ in
                self.cartPresenter.clearCart()
            }))
            alert.addAction(UIAlertAction(title: "Hayır", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        cartPresenter.checkOut()
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
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
        cell.setupCell(cartProduct: cartPresenter.products[indexPath.row], index: indexPath, delegate: self)
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
    func deleteRow(index: IndexPath) {
        tableView.deleteRows(at: [index], with: .automatic)
        var index = 0
        for cell in tableView.visibleCells {
            (cell as! CartTableViewCell).index = IndexPath(row: index, section: 0)
            index = index + 1
        }
    }
    
    func setQuantity(index: IndexPath, qty: Int) {
        (tableView.cellForRow(at: index) as? CartTableViewCell)?.setQuantity(qty: qty)
    }
    
    func setCartProducts() {
        cartPresenter.calculateTotalPrice()
        tableView.reloadData()
    }
    
    func setTotalPrice(totalPrice: Double, currency: String) {
        self.totalPriceLabel.text = currency + String(format: "%.2f", totalPrice)
    }
    
    func checkoutResponse(checkout: Checkout) {
        if let message = checkout.message {
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.cartPresenter.clearCart()
            }))
            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "", message: checkout.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func startLoading() {
        showActivityIndicator()
    }
    
    func finishLoading() {
        hideActivityIndicator()
    }
    
    func error(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//Cell
extension CartViewController: CellDelegate {
    func onClickMinusButton(index: IndexPath) {
        cartPresenter.decreaseCartProduct(product: cartPresenter.products[index.row], index: index)
    }
    
    func onClickPlusButton(index: IndexPath) {
        cartPresenter.increaseCartProduct(product: cartPresenter.products[index.row], index: index)
    }
}
