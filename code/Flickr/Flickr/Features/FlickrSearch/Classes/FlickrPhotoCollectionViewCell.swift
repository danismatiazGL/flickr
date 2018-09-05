//
//  FlickrPhotoCollectionViewCell.swift
//  Flickr
//
//  Created by Danis Matiaz on 9/5/18.
//  Copyright © 2018 Danis Matiaz - Gorilla Logic. All rights reserved.
//

import UIKit
import Kingfisher

class FlickrPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(photo: Photo) {
        if let url = URL(string: photo.url) {
            photoImageView.kf.setImage(with: url)
            let image = UIImage(named: "Flickr-Placeholder")
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url, placeholder: image)
        } else {
            let failedImage = UIImage.init(named: "Flickr-Placeholder")
            photoImageView.image = failedImage
        }
    }
}
