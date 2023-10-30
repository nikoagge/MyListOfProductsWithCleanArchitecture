//
//  ProductsListTableViewCell.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 30/10/23.
//

import Domain
import Networking
import UIKit

protocol ProductsListTableViewCellDelegate: AnyObject {
    func didSelect(product: Product)
}

class ProductsListTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @Injected(\.imageCacheManager)
    private var imageCacheManager: ImageCacheManager
    
    
    private var product: Product?
    private weak var delegate: ProductsListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func setupCell(
        product: Product,
        delegate: ProductsListTableViewCellDelegate
    ) {
        self.product = product
        self.delegate = delegate
                
        titleLabel.text = product.name
        descriptionLabel.text = product.price
        contentView.addTapGestureRecognizer {
            delegate.didSelect(product: product)
        }
        
        thumbnailImageView.layer.cornerRadius = 8
        guard let thumbnailUrl = product.thumbnail
        else {
            self.thumbnailImageView.image = UIImage(named: "no_image_available")
            
            return
        }
        
        if let image = imageCacheManager.getCachedImage(for: thumbnailUrl) {
            debugPrint("fetched from cache: \(thumbnailUrl)")
            self.thumbnailImageView.image = image
        } else {
            imageCacheManager.fetchImage(for: thumbnailUrl)
            {[weak self] image in
                debugPrint("fetched from network: \(thumbnailUrl)")
                self?.thumbnailImageView.image = image
                self?.imageCacheManager.cacheImage(image: image, for: thumbnailUrl)
            } errorCompletionHandler: {[weak self] _ in
                self?.thumbnailImageView.image = UIImage(named: "no_image_available")
            }
        }
    }
}
