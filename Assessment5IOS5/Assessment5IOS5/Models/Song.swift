//
//  Song.swift
//  Assessment5IOS5
//
//  Created by Colton Brenneman on 8/21/23.
//

import Foundation

struct TopLevelSongDictionary: Codable {
    let resultCount: Int
    let results: [SongResult]
}

struct SongResult: Codable {
    private enum CodingKeys: String, CodingKey {
        case songID = "collectionId"
        case songName = "trackName"
        case songDuration = "trackTimeMillis"
        case wrapperType
        case kind
        case collectionName
        
    }
    let songID: Int?
    let songName: String?
    let songDuration: Int?
    let collectionName: String?
    let wrapperType: String?
    let kind: String?
}

