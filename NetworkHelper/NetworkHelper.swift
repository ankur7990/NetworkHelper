//
//  NetworkHelper.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 22/07/24.
//

import Foundation

// network helper a songleton
// this means there will onl ever be one instance of this class
// throught the application. at no point will somone be able to create
// new instance e.g. NetworkHelper() will be a compiler error

class NetworkHelper{
    //shared instance to access in view controller
    
    static let shared = NetworkHelper()
    
    private var session:URLSession
    // we will make the defalt initializer private
    // required in order to be considered a singleton
    // also forbids anyone from creating an instane of netowrk helper
    
    private init(){
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with urlString:String,
                         completion: @escaping(Result<Data,AppError>) -> ()){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        // url session bedefault in suspended state we must write resume
        let dataTask = session.dataTask(with: url) { data, response, error in
            // will look three data response and error all are optional
            // check client network error
            // step 1
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            // step 2
            // downcasting as? HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                // if we are here in guard body that means we have no reponse,
                // because its nil
                completion(.failure(.noResponse))
                return
            }
            // step 3 unwrap data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            // step 4 : find out status code or validate
            
            switch urlResponse.statusCode {
            case 200...299:
                break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            //step 5 :
            
            completion(.success(data))
        }
        dataTask.resume()
    }
}
