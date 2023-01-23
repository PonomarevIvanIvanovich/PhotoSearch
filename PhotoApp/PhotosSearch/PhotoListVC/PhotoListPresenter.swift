//
//  PhotoListPresenter.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 30.10.2022.
//

import Foundation

protocol PhotoListPresentationLogic {
    func loadPhoto(model: PhotoListModel.loadPhoto.Response )
    func openPhoto(model: PhotoListModel.OpenPhoto.Response)
    func deletePhoto(model: PhotoListModel.DeletePhoto.Response)
}

final class PhotoListPtresrnter {
    weak var photoListVC: PhotoListVC?
}

extension PhotoListPtresrnter: PhotoListPresentationLogic {
    func deletePhoto(model: PhotoListModel.DeletePhoto.Response) {
        photoListVC?.deletePhotoLogic(model: PhotoListModel.DeletePhoto.ViewModel(model: model.model))
    }

    func openPhoto(model: PhotoListModel.OpenPhoto.Response) {
        photoListVC?.openPhoto(model: PhotoListModel.OpenPhoto.ViewModel(model: model.model))
    }

    func loadPhoto(model: PhotoListModel.loadPhoto.Response) {
        photoListVC?.loadData(model: PhotoListModel.loadPhoto.ViewModel(model: model.model))
    }
}
