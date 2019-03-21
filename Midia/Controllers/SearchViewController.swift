//
//  SearchViewController.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/5/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let mediaItemCellReuseIdentifier = "mediaItemCellIdentifier"

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var mediaItemProvider: MediaItemProvider! {
        didSet {
            // if view is loaded and mediaItemProvider is changed, clear screen
            if isViewLoaded {
                mediaItems = []
                collectionView.reloadData()
            }
        }
    }
    var mediaItems: [MediaItemProvidable] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
    }

}

extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }

        let mediaItem = mediaItems[indexPath.item]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider
        present(detailViewController, animated: true, completion: nil)
    }

}

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellReuseIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError("Unexpected cell type")
        }
        let mediaItem = mediaItems[indexPath.item]
        cell.mediaItem = mediaItem
        return cell
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryParams = searchBar.text, !queryParams.isEmpty else {
            return
        }

        activityIndicator.isHidden = false
        mediaItemProvider.getSearchMediaItems(withQueryParams: queryParams, success: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.collectionView.reloadData()
            self?.activityIndicator.isHidden = true

        }) { [weak self] (error) in
            self?.activityIndicator.isHidden = true
            let ac = UIAlertController(title: "Error", message: "No se ha podido obtener resultados", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(ac, animated: true)
        }
    }

}
