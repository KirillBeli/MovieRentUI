//
//  DetailsViewModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 15.04.2023.
//

import Foundation
import SwiftUI

class DetailsViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var movie: Movie?
    @Published var detailsData: DetailsData?
    @Published var promoImage: UIImage? = nil
    @Published var promoURL: URL = URL(fileURLWithPath: "")
    @Published var isLoading: Bool = false
    
    init(movie: Movie) {
        self.movie = movie
        getDetails()
    }
    
    //MARK: - Get Details Data
    func getDetails() {
        guard let movie = movie else { return }
        let urlDeatilsId = "\(String(describing: movie.id)).txt"
        let urlDetailsString = "\(URLManager.shared.urlDetailsBase)\(urlDeatilsId)"
        guard let url = URL(string: urlDetailsString) else {return}
        RequestManager.shared.getDataCombine(url: url, decodeTo: DetailsData.self) { [weak self] jsonData in
                self?.detailsData = jsonData
                self?.downloadImage(urlString: jsonData.imageURL)
                self?.getPromoURL(details: jsonData)
        }
    }
    
    //MARK: - Set Up Promo Link
    func getPromoURL(details: DetailsData) {
        guard let promoURL = URL(string: "\(String(describing: details.promoURL))") else {return}
        self.promoURL = promoURL
    }
    
    //MARK: - Download PromoImage
    func downloadImage(urlString: String?) {
        isLoading = true
        guard let urlString = urlString else { return }
        var urlCorect = urlString
        if !urlCorect.contains("https") {
            urlCorect = urlCorect.replacingOccurrences(of: "http", with: "https")
        }
        guard let urlDetailImage = URL(string: "\(urlCorect)") else {return}
        DownloadManager.shared.downloadImage(url: urlDetailImage) { [weak self] image in
            self?.promoImage = image
            self?.isLoading = false
        }
    }
}
