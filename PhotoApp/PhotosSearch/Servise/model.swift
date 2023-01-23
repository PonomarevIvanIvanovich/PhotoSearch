//
//  model.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 04.07.2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let greeting: String
    let instructions: [Instruction]
}

// MARK: - Instruction
struct Instruction: Codable {
    let id: String
    let createdAt, updatedAt: Date
    let width, height: Int
    let color: String
    let likes: Int
    let user: User
    let urls: Urls
    let links: InstructionLinks
    let location: Location
    let exif: Exif
    let views, downloads: Int

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color, likes, user, urls, links, location, exif, views, downloads
    }
}

// MARK: - Exif
struct Exif: Codable {
    let make, model, exposureTime, aperture: String
    let focalLength: String
    let iso: Int

    enum CodingKeys: String, CodingKey {
        case make, model
        case exposureTime = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
}

// MARK: - InstructionLinks
struct InstructionLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Location
struct Location: Codable {
    let name, city, country: String
    let position: Position
}

// MARK: - Position
struct Position: Codable {
    let latitude, longitude: Double
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct User: Codable {
    let id: String
    let updatedAt: Date
    let username, name, firstName, lastName: String
    let twitterUsername: String
    let portfolioURL: String
    let bio, location: String
    let links: UserLinks
    let profileImage: ProfileImage
    let totalCollections: Int
    let instagramUsername: String
    let totalLikes, totalPhotos: Int

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case totalCollections = "total_collections"
        case instagramUsername = "instagram_username"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}
