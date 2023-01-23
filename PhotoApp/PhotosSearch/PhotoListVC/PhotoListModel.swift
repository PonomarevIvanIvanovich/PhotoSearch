//
//  PhotoListModel.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 30.10.2022.
//

import Foundation

enum PhotoListModel {

    enum loadPhoto {

        struct Request {
        }

        struct Response {
            var model: [PhotoSearchModelImage]
        }

        struct ViewModel {
            var model: [PhotoSearchModelImage]
        }
    }

    enum OpenPhoto {

        struct Request {
            var model: PhotoSearchModelImage
        }

        struct Response {
            var model: PhotoSearchModelImage
        }

        struct ViewModel {
            var model: PhotoSearchModelImage
        }
    }

    enum DeletePhoto {

        struct Request {
            var modelID: String
        }

        struct Response {
            var model: [PhotoSearchModelImage]
        }

        struct ViewModel {
            var model: [PhotoSearchModelImage]
        }
    }
}
