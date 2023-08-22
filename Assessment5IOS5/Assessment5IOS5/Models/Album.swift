//
//  Album.swift
//  Assessment5IOS5
//
//  Created by Colton Brenneman on 8/21/23.
//

import Foundation

struct TopLevelAlbumDictionary: Codable {
    let resultCount: Int
    let results: [AlbumResult]
}

struct AlbumResult: Codable {
    private enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case trackCount
        case imagePath = "artworkUrl100"
        case albumID = "collectionId"
    }
    let artistName: String
    let albumName: String
    let trackCount: Int
    let imagePath: String?
    let albumID: Int
}
