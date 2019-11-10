//
//  File.swift
//  Film Locations
//
//  Created by Bilgehan Işıklı on 9.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

enum NFRemoteFetcherError: Error {
    case urlError
    case dataRecieveError
    case networkError(error: Error)
    case jsonParseError(description: String)
}

protocol NFRemoteFetchable {
    associatedtype DataType:Codable
    typealias Handler = (Result<DataType, Error>) -> Void
    var endPoint: String { get }
    func fetchData(_ handler: @escaping Handler)
}

extension NFRemoteFetchable {
    
    func fetchData(_ handler: @escaping Handler) {
        
        guard let url = URL(string: endPoint) else {
            handler(.failure(NFRemoteFetcherError.urlError))
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard error == nil else {
                handler(.failure(NFRemoteFetcherError.networkError(error: error!)))
                return
            }
            guard let responseData = data else {
                handler(.failure(NFRemoteFetcherError.dataRecieveError))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(DataType.self, from: responseData)
                handler(.success(data))
            } catch {
                handler(.failure(NFRemoteFetcherError.jsonParseError(description: "\(error)")))
            }
        }
        task.resume()
    }
}


