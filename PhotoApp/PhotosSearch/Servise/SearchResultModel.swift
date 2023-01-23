//
//  Model.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 04.07.2022.
//

import Foundation

struct SearchResultModel: Codable{
    let total: Int
    let results: [Photo]
}

struct Photo: Codable {
    let id: String

    let width: Int
    let height: Int
    let urls: [URLKing.RawValue : String]
    let user : User
    let created_at: String
    let likes: Int
    let description: String?
}

struct User: Codable {
    let name: String
}

enum URLKing: String {
    case raw
    case full
    case regular
    case small
    case thumb
}
