//
//  PhotoCollectionViewController.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.07.2022.
//

import UIKit

protocol PhotoSearchDisplayLogic {
    func collectionDisplay(viewModel: ViewCollectionModel.SearchPhoto.ViewModel)
    func selectionPhoto(viewModel: ViewCollectionModel.SelectionPhoto.ViewModel)
}

class PhotoCollectionVС: UICollectionViewController, UITextFieldDelegate {
    
    var timer = Timer()
    private var photos = [PhotoSearchModelImage]()
    private let itemPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var interactor: PhotoCollectionBusnessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCleanSwift()
        setupCollectionView()
        setupSearchBar()
    }

    private func tappedCollectionCell(photo: PhotoSearchModelImage) {
        let photoViewController = PhotoViewController()
        photoViewController.photo = photo
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    
    private func setupCleanSwift() {
        let photoCollectionPresenter = PhotoCollectionPresenter()
        let photoCollectionInteractor = PhotoCollectionInteractor()
        photoCollectionInteractor.photoCollectionPresenter = photoCollectionPresenter
        photoCollectionPresenter.PhotoCollectionVC = self
        self.interactor = photoCollectionInteractor
    }
    
    // MARK: - Setup elements
    
    private func setupCollectionView() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        collectionView.register(PhotosCollectionCell.self, forCellWithReuseIdentifier: PhotosCollectionCell.Identifier )
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        navigationItem.title = "Галерея изображений"
    }

    @objc func refreshCollection() {
        collectionView.reloadData()
        self.collectionView.refreshControl?.endRefreshing()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.showsScopeBar = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "поиск..."
    }
    
    // MARK: - CollectionViewDelegate, CollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionCell.Identifier,
                                                          for: indexPath) as? PhotosCollectionCell else {
            return UICollectionViewCell()
        }
        cell.photoImage.image = photos[indexPath.row].image
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.loadingOpenPhoto(requestModel: ViewCollectionModel.SelectionPhoto.Request(id: photos[indexPath.row].id))
    }
}
// MARK: - SearchBarDelegate

extension PhotoCollectionVС: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        collectionView.refreshControl?.beginRefreshing()
        interactor?.collectionLoading(requestModel:
                                        ViewCollectionModel.SearchPhoto.Request.init(searchString: searchBar.text!))
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        photos = [PhotoSearchModelImage]()
        collectionView.reloadData()
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension PhotoCollectionVС: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpaces = sectionInserts.left * (itemPerRow + 1)
        let availbleWidth = view.frame.width - paddingSpaces
        let widthPerItem = availbleWidth / itemPerRow
        let height = CGFloat(photos[indexPath.row].height) * (widthPerItem / CGFloat(photos[indexPath.row].width))
        return CGSize(width: widthPerItem, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}

extension PhotoCollectionVС: PhotoSearchDisplayLogic {
    func selectionPhoto(viewModel: ViewCollectionModel.SelectionPhoto.ViewModel) {
        tappedCollectionCell(photo: viewModel.model[0])
    }

    func collectionDisplay(viewModel: ViewCollectionModel.SearchPhoto.ViewModel) {
        photos = viewModel.model
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.collectionView.reloadData()
        })
    }
}
