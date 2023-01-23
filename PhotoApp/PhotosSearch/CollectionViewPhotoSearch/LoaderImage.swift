//
//  LoaderImage.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 27.10.2022.
//

import Foundation
import UIKit

final class LoaderImage {

    func createModel(photoArray: [Photo], complition: @escaping([PhotoSearchModelImage]) -> ()) {

        var arrayModel = [PhotoSearchModelImage]()
        for photo in photoArray {
            guard let photoUrl = photo.urls["regular"] else { return }
            loadImage(pictureURL: photoUrl) { image in
                let model = PhotoSearchModelImage(id: photo.id,
                                                  imageData: image.pngData()!,
                                                  height: photo.height,
                                                  width: photo.width,
                                                  created_at: photo.created_at,
                                                  userName: photo.user.name,
                                                  likes: String(photo.likes)
                )
                arrayModel.append(model)
                complition(arrayModel)
            }
        }
    }
}


private func loadImage(pictureURL: String, complition: @escaping(UIImage) ->()) {
    DispatchQueue.global().async {
        guard let imageUrl = URL(string: pictureURL) else  { return }
        guard let data = try? Data(contentsOf: imageUrl) else  { return }
        guard let image = UIImage(data: data) else { return }
        DispatchQueue.main.async {
            complition(image)
        }
    }
}

