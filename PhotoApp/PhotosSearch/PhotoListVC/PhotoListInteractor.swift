//
//  PhotoListInteractor.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 30.10.2022.
//

import Foundation

protocol PhotoListBusnessLogic {
    func loadData()
    func openPhoto(requestModel: PhotoListModel.OpenPhoto.Request)
    func deletePhoto(model: PhotoListModel.DeletePhoto.Request)
}

final class PhotoListInteractor {
    var photoListPresenter: PhotoListPresentationLogic?

}

extension PhotoListInteractor: PhotoListBusnessLogic {
    func deletePhoto(model: PhotoListModel.DeletePhoto.Request) {
        guard var arrayModel = PhotoStorage.photoModel else { return }
        for (index, mod) in arrayModel.enumerated() {
            if mod.id == model.modelID {
                arrayModel.remove(at: index)
            }
        }
        PhotoStorage.photoModel = arrayModel
        photoListPresenter?.deletePhoto(model: PhotoListModel.DeletePhoto.Response(model: arrayModel))
    }

    func loadData() {
        guard let photoData = PhotoStorage.photoModel else { return }
        photoListPresenter?.loadPhoto(model: PhotoListModel.loadPhoto.Response(model: photoData))
    }

    func openPhoto(requestModel: PhotoListModel.OpenPhoto.Request) {
        photoListPresenter?.openPhoto(model: PhotoListModel.OpenPhoto.Response(model: requestModel.model))
    }
}
