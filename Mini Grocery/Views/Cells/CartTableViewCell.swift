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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.imageView?.image = nil
    }
    
    func setupCell(cartProduct: Product?) {
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
    
    @IBAction func minusButtonClicked(_ sender: Any) {
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
    }
}
