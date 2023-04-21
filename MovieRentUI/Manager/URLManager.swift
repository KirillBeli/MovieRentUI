//
//  URLManager.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 12.04.2023.
//

import Foundation

class URLManager {
    
    static let shared = URLManager()
    private init() { }
    
    var urlBanner = URL(string: "https://x-mode.co.il/exam/allMovies/generalDeclaration.txt")
    var urlMovies = URL(string: "https://x-mode.co.il/exam/allMovies/allMovies.txt#")
    var urlDetailsBase = "https://x-mode.co.il/exam/descriptionMovies/"
    
}
