//
//  LocalizedString.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 21.04.2023.
//

import Foundation

struct LocalizedString {
    
    struct ImagesString {
        static let advertisingImage = "Cinema"
    }
    
    struct MoviesFilter {
        static let action = "action"
        static let comedy = "comedy"
        static let drama = "drama"
        static let fantasy = "fantasy"
        static let crime = "crime"
    }
    
    struct MoviesTitle: Identifiable {
        var id: String = UUID().uuidString
        
        static let action = "Action"
        static let comedy = "Comedy"
        static let drama = "Drama"
        static let fantasy = "Fantasy"
        static let crime = "Crime"
        static let movies = "Movies"
    }
}
