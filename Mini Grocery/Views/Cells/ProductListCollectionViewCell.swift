//
//  ProductListCollectionViewCell.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    var index: IndexPath?
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        minusButton.isHidden = true
        productQuantityLabel.isHidden = true
    }
    
    override func prepareForReuse() {
        minusButton.isHidden = true
        productQuantityLabel.isHidden = true
        self.productQuantityLabel.text = "0"
        self.productImage?.image = nil
    }
    
    func setupCell(product: Product?, index: IndexPath, delegate: CellDelegate) {
        self.delegate = delegate
        self.index = index
        imageIndicator.isHidden = false
        imageIndicator.startAnimating()
        if let count = product?.quantity {
            if count > 0 {
                self.productQuantityLabel.text = String(count)
                minusButton.isHidden = false
                productQuantityLabel.isHidden = false
            }else {
                minusButton.isHidden = true
                productQuantityLabel.isHidden = true
            }
        }
        
        if let productName = product?.name {
            self.productNameLabel.text = productName
        }
        
        if let productPrice = product?.price, let currency = product?.currency {
            productPriceLabel.text = currency + String(productPrice)
        }
        
        if let imageURL = product?.imageURL {
            productImage.load(url: imageURL, imageView: self.productImage) {
                self.imageIndicator.stopAnimating()
                self.imageIndicator.isHidden = true
            }
        }
    }
    
    func setQuantity(qty: Int) {
        self.productQuantityLabel.text = String(qty)
        if qty > 0 {
            minusButton.isHidden = false
            productQuantityLabel.isHidden = false
        }else {
            minusButton.isHidden = true
            productQuantityLabel.isHidden = true
        }
    }
    @IBAction func minusButtonClicked(_ sender: Any) {
        delegate?.onClickMinusButton(index: index!)
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        minusButton.isHidden = false
        productQuantityLabel.isHidden = false
        delegate?.onClickPlusButton(index: index!)
    }
}

protocol CellDelegate {
    func onClickMinusButton(index: IndexPath)
    func onClickPlusButton(index: IndexPath)
}
