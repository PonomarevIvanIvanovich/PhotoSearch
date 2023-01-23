//
//  ModelPhotoSearch.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 26.10.2022.
//

import Foundation
import UIKit

enum ViewCollectionModel {

    enum SearchPhoto {
        struct Request {
            var searchString: String
        }
        struct Response {
            var model: [PhotoSearchModelImage]
        }
        struct ViewModel {
            var model: [PhotoSearchModelImage]
        }
    }

    enum SelectionPhoto {
        struct Request {
            var id: String
        }
        struct Response {
            var model: [PhotoSearchModelImage]
        }
        struct ViewModel {
            var model: [PhotoSearchModelImage]
        }
    }
}
