//
//  InteractorPhotoSearch.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 26.10.2022.
//

import Foundation
import UIKit

protocol PhotoCollectionBusnessLogic {
    func collectionLoading(requestModel: ViewCollectionModel.SearchPhoto.Request)
    func loadingOpenPhoto(requestModel: ViewCollectionModel.SelectionPhoto.Request)
}

class PhotoCollectionInteractor {

    private let dataFetcher = NetworkDataFetcher()
    var loaderImage = LoaderImage()
    var photoCollectionPresenter: PhotoCollectionPresentationLogic?
    let photoCache = PhotoCache()
}

extension PhotoCollectionInteractor: PhotoCollectionBusnessLogic {

    func collectionLoading(requestModel: ViewCollectionModel.SearchPhoto.Request) {
        self.dataFetcher.fetchImages(searchTerm: requestModel.searchString) { [weak self] (searchResults) in
            guard let searchResults = searchResults else { return }
            self?.loaderImage.createModel(photoArray: searchResults.results) { model in
                self?.photoCache.cachePhotoModel(models: model)
                self?.photoCollectionPresenter?.collectionPresentation(responseModel: ViewCollectionModel.SearchPhoto.Response(model: model))
            }
        }
    }
    
    func loadingOpenPhoto(requestModel: ViewCollectionModel.SelectionPhoto.Request) {
        guard let models = photoCache.loadCache() else { return }
        var modelArray = [PhotoSearchModelImage]()
        for (index, model) in models.enumerated() {
            if model.id == requestModel.id {
                modelArray.append(models[index])
            }
        }
        self.photoCollectionPresenter?.presentationOpenPhoto(responseModel: ViewCollectionModel.SelectionPhoto.Response(model: modelArray))
    }
}
