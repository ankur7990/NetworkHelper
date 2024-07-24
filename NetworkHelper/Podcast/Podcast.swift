//
//  Podcast.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 22/07/24.
//

import Foundation

struct AppleSearchAPI:Decodable {
    let results: [Podcast]
}
struct Podcast: Decodable {
    let artistName:String
    let collectionName:String
}
