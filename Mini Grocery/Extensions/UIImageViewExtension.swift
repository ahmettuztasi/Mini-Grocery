//
//  UIImageViewExtension.swift
//  Mini Grocery
//
//  Created by ahmet on 13.12.2020.
//

import UIKit

extension UIImageView {
    func load(url: String, imageView: UIImageView, completion: @escaping() -> Void) {
        if let url = URL(string: url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            if imageView == self {
                                self?.image = image
                                completion()
                            }
                        }
                    }
                }
            }
        }
    }
}
