//
//  Cach.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 02.11.2022.
//

import Foundation

final class PhotoCache {

    let key: NSString = "CachKey"
    let cach = NSCache<NSString, AnyObject>()

    func cachePhotoModel(models: [PhotoSearchModelImage]) {
        let model = models as AnyObject
        cach.setObject(model, forKey: key)
    }

    func loadCache() -> [PhotoSearchModelImage]? {
        guard let photoArrray = cach.object(forKey: key) else { return nil }
        guard let models = photoArrray as? [PhotoSearchModelImage] else { return nil }
        return models
    }
}
