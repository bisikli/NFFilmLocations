//
//  NFRemoveMovieFetcher.swift
//  Film Locations
//
//  Created by Bilgehan Işıklı on 9.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

class NFRemoteMovieFetcher: NFMovieFetchable, NFRemoteFetchable {
    typealias DataType = [NFMovie]
    
    let endPoint: String = "http://assets.nflxext.com/ffe/siteui/iosui/filmData.json"
    func fetchMovies(_ handler: @escaping NFRemoteMovieFetcher.Handler) {
        fetchData(handler)
    }
}
