//
//  PhotoSearchModel.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 30.10.2022.
//

import Foundation
import UIKit
import UIKit

struct PhotoSearchModelImage: Codable {

    var id: String
    var imageData: Data
    var height: Int
    var width: Int
    var created_at: String
    var userName: String
    var likes: String

    var image: UIImage? {
        UIImage(data: imageData)
    }

    init(id: String, imageData: Data, height: Int, width: Int,created_at: String, userName: String, likes: String ) {
        self.id = id
        self.imageData = imageData
        self.height = height
        self.width = width
        self.created_at = created_at
        self.userName = userName
        self.likes = likes
    }
}
