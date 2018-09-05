//
//  PhotoDetailsViewController.swift
//  Flickr
//
//  Created by Danis Matiaz on 9/5/18.
//  Copyright © 2018 Danis Matiaz - Gorilla Logic. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUserInterface()
    }

    private func initUserInterface() {
        if let currentPhoto = self.photo {
            if let url = URL(string: NetworkManager.getHightDefinitionURL(for: currentPhoto)) {
                photoImageView.contentMode = .scaleAspectFill
                photoImageView.kf.indicatorType = .activity
                photoImageView.kf.setImage(with: url)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func set(photo: Photo) {
        self.photo = photo
    }

    @IBAction func closePhotoDetailsACtion(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
