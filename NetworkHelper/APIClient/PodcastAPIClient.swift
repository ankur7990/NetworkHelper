//
//  PodcastAPIClient.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 22/07/24.
//

import Foundation

struct PodcastAPIClient{
    static func getPodcast(completion: @escaping (Result<[Podcast],AppError>) -> () ) {
        
        let urlString = "https://itunes.apple.com/search?media=podcast&limit=200&term=swift"
        //var podcast = [Podcast]()
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result {
            case .success(let data):
                do{
                    let podcast = try JSONDecoder().decode(AppleSearchAPI.self, from: data) // here to check if its dict or array while passing data
                    let podcasts = podcast.results
                    completion(.success(podcasts))
                }catch {
                    completion(.failure(.decodingError(error)))
                    
                }
            case .failure(let error):
                completion(.failure(.decodingError(error)))
            }
        }
    }
}
