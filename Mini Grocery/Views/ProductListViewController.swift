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
        confiugureNavBar()
        
        productListPresenter.setDelegate(delegate: self)
        productListPresenter.getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func confiugureNavBar() {
        self.navigationItem.title = "Mini Bakkal"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartBtnTapped))
    }
    
    @objc func cartBtnTapped() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CarViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
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
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width/3.0) - 20
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
    }
}

//Presenter Callbacks
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
