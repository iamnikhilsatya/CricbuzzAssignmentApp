//
//  Rating.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import Foundation

struct Rating: Decodable {
    let source: String?
    let value: String?
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

enum RatingSource: String, CaseIterable, Identifiable, Decodable {
    case imdb = "Internet Movie Database"
    case rottenTomatoes = "Rotten Tomatoes"
    case metacritic = "Metacritic"
    case none = "none"
    
    var id: String { self.rawValue }
}
