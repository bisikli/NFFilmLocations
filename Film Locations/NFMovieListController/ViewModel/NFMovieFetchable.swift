//
//  NFMovieFetchable.swift
//  Film Locations
//
//  Created by Bilgehan Işıklı on 9.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

protocol NFMovieFetchable {
    typealias Handler = (Result<[NFMovie], Error>) -> Void
    func fetchMovies(_ handler: @escaping Handler)
}

