//
//  NFMovie.swift
//  Film Locations
//
//  Created by Bilgehan Işıklı on 9.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

struct NFActor: RawRepresentable,Hashable,Codable {
    let rawValue: String
}

struct NFDirector: RawRepresentable,Hashable,Codable {
    let rawValue: String
}

struct NFMovie {
    
    let title: String
    let year: String
    let actors: [NFActor]
    let writers: [String]
    let director: NFDirector
    let company: String
    
    let longitude: Double
    let latitude: Double
}

extension NFMovie: Codable {
    enum CodingKeys: CodingKey {
        case title
        case release_year
        case actors
        case director
        case writers
        case production_company
        case longitude
        case latitude
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title    = try container.decode(String.self, forKey: .title)
        self.year     = try container.decode(String.self, forKey: .release_year)
        self.actors   = try container.decode([NFActor].self, forKey: .actors)
        self.director = try container.decode(NFDirector.self, forKey: .director)
        self.writers  = try container.decodeIfPresent([String].self, forKey: .writers) ?? []
        self.company  = try container.decode(String.self, forKey: .production_company)
        
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.latitude  = try container.decode(Double.self, forKey: .latitude)

    }
    
    func encode(to encoder: Encoder) throws {
        //encode implementation
    }
}
