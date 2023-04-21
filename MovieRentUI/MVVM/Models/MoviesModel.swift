//
//  MoviesModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 21.04.2023.
//

import Foundation

//MARK: - Movies
public struct MoviesData: Codable {
    var movies: [Movie]
}

enum MovieCategory: String {
    case all = "All"
    case action = "Action"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case crime = "Crime"
    case comedy = "Comedy"
    
    init(tag: Int) {
        switch tag {
        case 0: self = .all
        case 1: self = .action
        case 2: self = .drama
        case 3: self = .fantasy
        case 4: self = .crime
        case 5: self = .comedy
        default: self = .all
        }
    }
}

public struct Movie: Codable, Equatable, Identifiable, Hashable {
    public let id: String
    let name: String
    let year: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case year = "year"
        case category = "category"
    }
}
