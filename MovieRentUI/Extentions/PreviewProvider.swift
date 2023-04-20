//
//  PreviewProvider.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 16.04.2023.
//

import SwiftUI

extension PreviewProvider {
    
    static var developer: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let movie = Movie(id: "1000", name: "Kirill", year: "1992", category: "Comedy")
    
    let movies = MoviesData(movies: [Movie(id: "2000", name: "Kirill", year: "1992", category: "Comedy")])
    
    let details = DetailsData(id: "2000", name: "Kirill", year: "1992", category: "Comedy", description: "Some description", imageURL: "https://images.pexels.com/photos/1557652/pexels-photo-1557652.jpeg", promoURL: "https://www.youtube.com/watch?v=vBGkvkPkD5g", rate: "10", hour: "1:05")
}
