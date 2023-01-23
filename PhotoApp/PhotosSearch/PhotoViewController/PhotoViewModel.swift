//
//  PhotoViewModel.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.11.2022.
//

import Foundation

enum PhotoViewModel {

    enum SavePhoto {

        struct Request {
            var model: PhotoSearchModelImage
        }

        struct Response {
        }

        struct ViewModel {
        }
    }

    enum DeletePhoto {

        struct Request {
            var model: PhotoSearchModelImage
        }

        struct Response {
        }

        struct ViewModel {
        }
    }

    enum LoadPhoto {

        struct Request {
            var model: PhotoSearchModelImage
        }

        struct Response {
            var model: PhotoSearchModelImage
            var saveBool: Bool
        }

        struct ViewModel {
            var model: PhotoSearchModelImage
            var saveBool: Bool
        }
    }


}
