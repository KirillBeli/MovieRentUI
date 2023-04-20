//
//  LaunchViewModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 13.04.2023.
//

import Foundation
import SwiftUI

class LaunchViewModel: ObservableObject {
    
//    @ObservedObject private(set) var listModel: ListViewModel = ListViewModel()
    @Published private(set) var bannerData: BannerData?
    @Published private(set) var adImage: Image?
    @Published  var moviesResult: [Movie] = []
//    @Published  var filterResult: [Movie] = []
    @Published var firstTimeOpen: Bool = true
    
    init() {
//        self.getBannerData()
        self.getBanner()
        self.getMovies()
//        self.getMoviesData()
    }
    
    func getBanner() {
        guard let url = URLManager.shared.urlBanner else { return }
        RequestManager.shared.getDataCombine(url: url, decodeTo: BannerData.self) { [weak self] jsonData in
            DispatchQueue.main.async {
                self?.bannerData = jsonData
                guard var imageUrl = self?.bannerData?.banner[1].imageUrl else {return}
                if !imageUrl.contains("https") {
                    imageUrl = imageUrl.replacingOccurrences(of: "http", with: "https")
                }
                imageUrl = imageUrl.replacingOccurrences(of: ".jpg.jpg", with: ".jpg")
                guard let url = URL(string: "\(imageUrl)") else {return print("Convert url error")}
                self?.downloadAdvertisingImage(url: url)
            }
        }
    }
    
//    func getBannerData() {
//        RequestManager.shared.getData(url: URLManager.shared.urlBanner, decodeTo: BannerData.self) { [weak self] jsonData in
//            DispatchQueue.main.async {
//                self?.bannerData = jsonData
//                guard var imageUrl = self?.bannerData?.banner[1].imageUrl else {return}
//                if !imageUrl.contains("https") {
//                    imageUrl = imageUrl.replacingOccurrences(of: "http", with: "https")
//                }
//                imageUrl = imageUrl.replacingOccurrences(of: ".jpg.jpg", with: ".jpg")
//                guard let url = URL(string: "\(imageUrl)") else {return print("Convert url error")}
//                self?.downloadAdvertisingImage(url: url)
//            }
//        }
//    }
    
    func downloadAdvertisingImage(url: URL) {
        RequestManager.shared.downloadImage(url: url) { [weak self] data, error in
            if let data = data {
                DispatchQueue.main.async {
                    let adImage = Image(uiImage: UIImage(data: data) ?? UIImage())
                    self?.adImage = adImage
                }
            }
        }
    }
    
    func getMovies() {
        guard let url = URLManager.shared.urlMovies else { return }
        RequestManager.shared.getDataCombine(url: url, decodeTo: MoviesData.self) { [weak self] jsonData in
            DispatchQueue.main.async {
                self?.moviesResult = jsonData.movies
            }
        }
    }
    
//    func getMoviesData() {
//        guard let url = URLManager.shared.urlMovies else {return}
//        RequestManager.shared.getData(url: url, decodeTo: MoviesData.self) { [weak self] jsonMovies in
//            DispatchQueue.main.async {
//                self?.moviesResult = jsonMovies.movies
////                self?.filterResult = jsonMovies.movies
//            }
//
//        }
//    }
}

