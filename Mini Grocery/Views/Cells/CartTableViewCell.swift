//
//  CartTableViewCell.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    var index: IndexPath?
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.imageView?.image = nil
    }
    
    func setupCell(cartProduct: Product?, index: IndexPath, delegate: CellDelegate) {
        self.delegate = delegate
        self.index = index
        imageIndicator.isHidden = false
        imageIndicator.startAnimating()
        if let imageURL = cartProduct?.imageURL {
            productImage.load(url: imageURL, imageView: self.productImage, completion: {
                self.imageIndicator.stopAnimating()
                self.imageIndicator.isHidden = true
            })
        }
        
        if let productName = cartProduct?.name {
            productNameLabel.text = productName
        }
        
        if let productPrice = cartProduct?.price, let currency = cartProduct?.currency {
            productPriceLabel.text = currency + String(productPrice)
        }
        
        if let productQuantity = cartProduct?.quantity {
            productQuantityLabel.text = String(productQuantity)
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
