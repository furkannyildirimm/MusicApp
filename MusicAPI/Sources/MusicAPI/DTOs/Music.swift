//
//  Music.swift
//  
//
//  Created by STARK on 6.06.2023.
//

import Foundation

public struct MusicResult: Decodable {
    public let resultCount: Int?
    public let results: [Music]?
}

public struct Music: Decodable {
    public let artistId, collectionId, trackId: Int?
    public let artistName: String?
    public let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    public let artistViewUrl, collectionViewUrl, trackViewUrl: String?
    public let previewUrl: String?
    public let artworkUrl30, artworkUrl60, artworkUrl100: String?
    public let collectionPrice, trackPrice: Double?
    public let primaryGenreName: String?
}
