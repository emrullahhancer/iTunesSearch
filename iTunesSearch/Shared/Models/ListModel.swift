//
//  ListModel.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 24.08.2021.
//

import Foundation

struct ListModel: Codable {
    let results : [Results]?
    let resultCount: Int?
}

struct Results: Codable {
    let collectionName, artworkUrl100, releaseDate, currency, longDescription: String?
    let collectionPrice: Double?
    let trackId: Int?
}
