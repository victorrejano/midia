//
//  HomeViewController.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/26/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

enum MediaItemViewControllerState {
    case loading
    case noResults
    case failure
    case ready
}

class HomeViewController: UIViewController {

    let mediaItemCellIdentifier = "mediaItemCell"

    var mediaItemProvider: MediaItemProvider! {
        didSet {
            // if view is loaded and mediaItemProvider is changed, reload data
            if isViewLoaded {
                loadData()
            }
        }
    }
    private var mediaItems: [MediaItemProvidable] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var failureEmojiLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    var state: MediaItemViewControllerState = .ready {
        willSet {
            guard state != newValue else { return }

            // Ocultamos todas las vistas relacionadas con los estados y después mostramos las que corresponden
            [collectionView, activityIndicatorView, failureEmojiLabel, statusLabel].forEach { (view) in
                view?.isHidden = true
            }

            switch newValue {
            case .loading:
                activityIndicatorView.isHidden = false
            case .noResults:
                failureEmojiLabel.isHidden = false
                failureEmojiLabel.text = "☹️"
                statusLabel.isHidden = false
                statusLabel.text = "No hay nada que mostrar!!"
            case .failure:
                failureEmojiLabel.isHidden = false
                failureEmojiLabel.text = "❌"
                statusLabel.isHidden = false
                statusLabel.text = "Error conectando!!"
            case .ready:
                collectionView.isHidden = false
                collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

}

extension HomeViewController: UICollectionViewDelegate {

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

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError()
        }
        let mediaItem = mediaItems[indexPath.item]
        cell.mediaItem = mediaItem
        return cell
    }

    private func loadData() {
        state = .loading
        mediaItemProvider.getHomeMediaItems(onSuccess: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.state = mediaItems.count > 0 ? .ready : .noResults
        }) { [weak self] (error) in
            self?.state = .failure
        }
    }
}
