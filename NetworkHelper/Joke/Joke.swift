//
//  Joke.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 22/07/24.
//

import Foundation

// encodeble : encoding data to send to web api
// decodable : decoding JSON or other data from the web
// together they are packages as codable

struct Joke : Decodable {
    var type:String
    var setup:String
    var punchline:String
    var id:Int
}
