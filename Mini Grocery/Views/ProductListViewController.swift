//
//  ProductListViewController.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import UIKit

class ProductListViewController: UICollectionViewController {
    let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
    var activityView: UIActivityIndicatorView?
    
    private let productListPresenter = ProductListPresenter(productListService: ProductListService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        confiugureNavBar()
        
        productListPresenter.setDelegate(delegate: self)
        productListPresenter.getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func confiugureNavBar() {
        self.navigationItem.title = "Mini Bakkal"
        let cartButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        cartButton.tintColor = .black
        
        self.lblBadge.backgroundColor = .white
        self.lblBadge.clipsToBounds = true
        self.lblBadge.layer.cornerRadius = 7
        self.lblBadge.textColor = .black
        self.lblBadge.textAlignment = .center
        self.lblBadge.font = self.lblBadge.font.withSize(12)
        self.lblBadge.text = "0"

        cartButton.addSubview(self.lblBadge)
        cartButton.addTarget(self, action: #selector(onClickCartButton), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
    }
    
    @objc func onClickCartButton() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            setCartProducts()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setCartProducts() {
        CartRepository.shared.cartProducts = productListPresenter.products
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

//Collection View
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCollectionViewCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListPresenter.products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
        cell.setupCell(product: productListPresenter.products[indexPath.row], index: indexPath, delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width/3.0) - 20
        
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
    }
}

//Presenter Callbacks
extension ProductListViewController: ProductListPresenterDelegate {
    func setQuantity(index: IndexPath, qty: Int) {
        (collectionView.cellForItem(at: index) as? ProductListCollectionViewCell)?.setQuantity(qty: qty)
    }
    
    func setCartBadge(productCount: Int) {
        self.lblBadge.text = String(productCount)
    }
    
    func startLoading() {
        showActivityIndicator()
    }
    
    func finishLoading() {
        hideActivityIndicator()
    }
    
    func setProducts(products: Products) {
        collectionView.reloadData()
    }
    
    func error(error: Error) {
        //show alert
        print(error)
    }
}

extension ProductListViewController: ProductListCVCellDelegate {
    func onClickMinusButton(index: IndexPath) {
        productListPresenter.decreaseCartProduct(product: productListPresenter.products[index.row], index: index)
    }
    
    func onClickPlusButton(index: IndexPath) {
        productListPresenter.increaseCartProduct(product: productListPresenter.products[index.row], index: index)
    }
}
