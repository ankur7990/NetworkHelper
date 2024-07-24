//
//  JokeAPIClient.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 22/07/24.
//

import Foundation

struct JokeAPIClient{
    
    static func getJokes(completion: @escaping(Result<[Joke],AppError>) -> ()){
        let endPointURL = "https://official-joke-api.appspot.com/jokes/programming/ten"
        NetworkHelper.shared.performDataTask(with: endPointURL) { (result) in
            switch result {
            case .failure(let appError):
                print("app eror \(appError)")
            case .success(let data):
                // here we need data for to create an array of Jokes
                do{
                    let jokes = try JSONDecoder().decode([Joke].self, from: data)
                    completion(.success(jokes))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
