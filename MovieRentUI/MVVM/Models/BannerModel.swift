//
//  BannerModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 21.04.2023.
//

import Foundation

//MARK: - Banner
public struct BannerData: Codable {
    let banner: [Banner]
}

public struct Banner: Codable, Equatable {
    let isImage: String?
    let imageUrl: String?
    let videoUrl: String?

    enum CodingKeys: String, CodingKey {
        case isImage = "isImage"
        case imageUrl = "imageUrl"
        case videoUrl = "videoUrl"
    }
}
