//
//  PhotoStorage.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 17.07.2022.
//

import Foundation
import UIKit

final class PhotoStorage {
    static let key = "saveData"
    static var photoModel: [PhotoSearchModelImage]? {
        get {
            guard let savedData = UserDefaults.standard.data(forKey: PhotoStorage.key),
                  let decodedModel = try? JSONDecoder().decode([PhotoSearchModelImage].self, from: savedData)
            else { return [] }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            if let photoModel = newValue {
                if let saveData = try? JSONEncoder().encode(photoModel) {
                    defaults.set(saveData, forKey: PhotoStorage.key)
                }
            }
        }
    }
}
