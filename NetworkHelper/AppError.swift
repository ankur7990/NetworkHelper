//
//  AppError.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 22/07/24.
//

import Foundation

// error handling against network requests

enum AppError : Error {
    case badURL(String) // associated value : if we want to capture data around this case we use it
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMIMEType(String) // image/jpg etc
}   	        
