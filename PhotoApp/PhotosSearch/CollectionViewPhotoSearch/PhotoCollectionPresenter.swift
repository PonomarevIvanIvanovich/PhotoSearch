//
//  PresenterPhotoSearch.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 26.10.2022.
//

import Foundation
import UIKit

protocol PhotoCollectionPresentationLogic {
    func collectionPresentation(responseModel: ViewCollectionModel.SearchPhoto.Response)
    func presentationOpenPhoto(responseModel: ViewCollectionModel.SelectionPhoto.Response)
    
}

class PhotoCollectionPresenter {
    
    weak var PhotoCollectionVC: PhotoCollectionVС?
    private var timer = Timer()
    private let date = Date()
    private let formatter = DateFormatter()

    private func to(format:String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            let dateResult = formatter.string(from: date)
            return dateResult
        }
}

extension PhotoCollectionPresenter: PhotoCollectionPresentationLogic {

    func presentationOpenPhoto(responseModel: ViewCollectionModel.SelectionPhoto.Response) {
        var model = responseModel.model
        for (index,_) in model.enumerated() {
            model[index].created_at = to(format: "MM/dd/yyyy")
        }
        self.PhotoCollectionVC?.selectionPhoto(viewModel: ViewCollectionModel.SelectionPhoto.ViewModel(model: model))
    }

    func collectionPresentation(responseModel: ViewCollectionModel.SearchPhoto.Response) {
        self.PhotoCollectionVC?.collectionDisplay(viewModel: ViewCollectionModel.SearchPhoto.ViewModel(model: responseModel.model))
    }
}
