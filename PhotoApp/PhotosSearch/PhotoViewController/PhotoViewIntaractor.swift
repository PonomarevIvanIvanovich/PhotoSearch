//
//  PhotoViewIntaractor.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.11.2022.
//

import Foundation

protocol PhotoViewBusnessLogic {
    func savePhoto(model: PhotoViewModel.SavePhoto.Request)
    func deletePhoto(model: PhotoViewModel.DeletePhoto.Request)
    func loadPhoto(model: PhotoViewModel.LoadPhoto.Request)
}

class PhotoViewIneractor {
    var photoViewPresenter: PhotoViewPresentationLogic?
}

extension PhotoViewIneractor: PhotoViewBusnessLogic {
    
    func loadPhoto(model: PhotoViewModel.LoadPhoto.Request) {
        var saveBool = Bool()
        guard let arrayModel = PhotoStorage.photoModel else { return }
        for mod in arrayModel {
            if mod.id == model.model.id {
                saveBool = true
                break
            }
        }
        photoViewPresenter?.loadPhoto(model: PhotoViewModel.LoadPhoto.Response(model: model.model, saveBool: saveBool))
    }

    func deletePhoto(model: PhotoViewModel.DeletePhoto.Request) {
        guard var arrayModel = PhotoStorage.photoModel else { return }
        for (index, mod) in arrayModel.enumerated() {
            if mod.id == model.model.id {
                arrayModel.remove(at: index)
            }
        }
        PhotoStorage.photoModel = arrayModel
        photoViewPresenter?.deletePhoto()
    }

    func savePhoto(model: PhotoViewModel.SavePhoto.Request) {
        if var arrayModel = PhotoStorage.photoModel {
            arrayModel.append(model.model)
            PhotoStorage.photoModel = arrayModel
            photoViewPresenter?.savephoto()
        } else {
            PhotoStorage.photoModel = [model.model]
        }
    }
}
