//
//  PhotoViewPresenter.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.11.2022.
//

import Foundation

protocol PhotoViewPresentationLogic {
    func savephoto()
    func deletePhoto()
    func loadPhoto(model: PhotoViewModel.LoadPhoto.Response)
}

class PhotoViewPresenter {
    weak var photoViewController: PhotoViewController?
}

extension PhotoViewPresenter: PhotoViewPresentationLogic {
    func loadPhoto(model: PhotoViewModel.LoadPhoto.Response) {
        photoViewController?.loadPhoto(model: PhotoViewModel.LoadPhoto.ViewModel(model: model.model, saveBool: model.saveBool))
    }

    func deletePhoto() {
        photoViewController?.deletephotoCicl()
    }

    func savephoto() {
        photoViewController?.savePhotoCicl()
    }
}


