//
//  PhotoModel.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 15.07.2022.
//

import Foundation
import UIKit

struct PhotoModel: Codable {
    let userName: String
    let dateCreate: String
    let likes: String
    let image: String
}
