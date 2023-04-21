//
//  LaunchViewModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 13.04.2023.
//

import Foundation
import SwiftUI

class LaunchViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published private(set) var bannerData: BannerData?
    @Published private(set) var adImage: UIImage? = nil
    @Published  var moviesResult: [Movie] = []
    @Published var firstTimeOpen: Bool = true
    
    init() {
        self.getBanner()
        self.getMovies()
    }
    
    //MARK: - Get Banner Data
    func getBanner() {
        guard let url = URLManager.shared.urlBanner else { return }
        RequestManager.shared.getDataCombine(url: url, decodeTo: BannerData.self) { [weak self] jsonData in
                self?.bannerData = jsonData
                guard var imageUrl = self?.bannerData?.banner[1].imageUrl else {return}
                if !imageUrl.contains("https") {
                    imageUrl = imageUrl.replacingOccurrences(of: "http", with: "https")
                }
                imageUrl = imageUrl.replacingOccurrences(of: ".jpg.jpg", with: ".jpg")
                guard let url = URL(string: "\(imageUrl)") else {return print("Convert url error")}
            self?.downloadImage(url: url)
        }
    }
    
    //MARK: - Download Advertising Image
    func downloadImage(url: URL) {
        DownloadManager.shared.downloadImage(url: url) { [weak self] image in
            self?.adImage = image
        }
    }
    
    //MARK: - Get Movies Data
    func getMovies() {
        guard let url = URLManager.shared.urlMovies else { return }
        RequestManager.shared.getDataCombine(url: url, decodeTo: MoviesData.self) { [weak self] jsonData in
                self?.moviesResult = jsonData.movies
        }
    }
    
}

