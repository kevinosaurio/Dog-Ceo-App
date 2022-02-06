//
//  DogBreedImageCell.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 06-02-22.
//

import Foundation
import UIKit
import SDWebImage

class DogBreedImageCell: UITableViewCell {
    lazy var customImageView:UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setUp(imageUrl: String) {
        if customImageView.superview == nil {
            contentView.addSubView(customImageView, equalTo: contentView, padding: UIEdgeInsets(top: 6,
                                                                                                left: 0,
                                                                                                bottom: -16,
                                                                                                right: 0))
        }
        customImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "LoadignDog"))
    }
}
