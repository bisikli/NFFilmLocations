//
//  NFMovieListControllerModel.swift
//  Film Locations
//
//  Created by Bilgehan Işıklı on 9.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation


class NFMovieListControllerModel {
    
    enum Action {
        case fetchMovies
    }
    
    enum FetchStatus {
        case started
        case ended
        case error(Error)
        case success
    }

    
    private let movieFetcher: NFMovieFetchable
    private(set) var movies = [NFMovie]()
    
    var onFetchStatusChanged : (FetchStatus)->Void = { _ in }
    
    init(_ fetcher: NFMovieFetchable = NFRemoteMovieFetcher()) {
        self.movieFetcher = fetcher
    }
    
    func send(_ action: Action) {
        switch action {
        case .fetchMovies:
            onFetchStatusChanged(.started)
            movieFetcher.fetchMovies { [weak self] (result) in
                DispatchQueue.main.async {
                     self?.onFetchStatusChanged(.ended)
                    switch result {
                    case .failure(let error):
                        self?.onFetchStatusChanged(.error(error))
                    case .success(let movies):
                        self?.movies = movies
                        self?.onFetchStatusChanged(.success)
                    }
                }
            }
        }
    }
    
}
