//
//  DetailsModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 21.04.2023.
//

import Foundation

//MARK: - Details
public struct DetailsData: Codable {
    let id, name, year, category: String
    let description: String
    let imageURL: String
    let promoURL: String
    let rate, hour: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, year, category, description
        case imageURL = "imageUrl"
        case promoURL = "promoUrl"
        case rate, hour
    }
}
