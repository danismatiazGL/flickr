//
//  FlickrSearchViewController.swift
//  Flickr
//
//  Created by Danis Matiaz on 9/5/18.
//  Copyright © 2018 Danis Matiaz - Gorilla Logic. All rights reserved.
//

import UIKit

class FlickrSearchViewController: UIViewController {
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    private var photosList: [Photo] = [] // To do: Move this to a ViewModel
    private var searchQuery = "" // To do: Move this to a ViewModel
    private var page = 0 // To do: Move this to a ViewModel
    var collectionViewCellSize = 0
    var isLoadingMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUserInterface()
        self.searchPhotos()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initUserInterface() {
        let viewSize = self.view.frame.size.width
        let itemSize = (viewSize - 2) / 3
        self.collectionViewCellSize = Int(itemSize)
    }
}

extension FlickrSearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // To Do: Handle a time delay OR minumun characters count to trigger the
        // request to minimize the API calls OR wait for editing to end
        searchQuery = searchText
        page = 0
        self.photosList.removeAll()
        self.photosCollectionView.reloadData()
        self.searchPhotos()
    }
}

extension FlickrSearchViewController { // To do: Move this to a ViewModel
    private func searchPhotos() {
        isLoadingMore = true
        page += 1
        NetworkManager.searchPhotos(query: searchQuery,
                                    page: page) { (status, photos, _) in
                                        if status == .success {
                                            if let photoList = photos {
                                                self.photosList.append(contentsOf: photoList)
                                            }
                                        } else { self.photosList.removeAll() }
                                        self.photosCollectionView.reloadData()
                                        self.isLoadingMore = false
        }
    }
}

extension FlickrSearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideKeyboardFromSearchBar()
    }
    func hideKeyboardFromSearchBar() {
        if searchbar.isFirstResponder {
            searchbar.resignFirstResponder()
        }
    }
}

extension FlickrSearchViewController: UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // To do: Make it full screen
        collectionView.deselectItem(at: indexPath, animated: true)
        self.hideKeyboardFromSearchBar()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: flickerCollectionViewCell, for: indexPath)
        configureCell(cell: cell, forItemAt: indexPath)
        return cell
    }

    func configureCell(cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let customCell = cell as? FlickrPhotoCollectionViewCell else { return }
        let selectedPhoto = photosList[indexPath.row]
        customCell.configureCell(photo: selectedPhoto)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellSize, height: collectionViewCellSize)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == photosList.count - 1 && !isLoadingMore {
            searchPhotos()
        }
    }
}
