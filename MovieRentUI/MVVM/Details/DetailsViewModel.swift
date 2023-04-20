//
//  DetailsViewModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 15.04.2023.
//

import Foundation
import SwiftUI

class DetailsViewModel: ObservableObject {
    
//    @ObservedObject var homeModel: HomeViewModel = HomeViewModel()
    @Published var movie: Movie?
    @Published var detailsData: DetailsData?
    @Published var promoImage: Image?
    @Published var promoURL: URL = URL(fileURLWithPath: "")
    init() {
        
    }
    
    //MARK: - Get Details
    
    func getDetails() {
        guard let movie = movie else { return }
        let urlDeatilsId = "\(String(describing: movie.id)).txt"
        let urlDetailsString = "\(URLManager.shared.urlDetailsBase)\(urlDeatilsId)"
        guard let url = URL(string: urlDetailsString) else {return}
        RequestManager.shared.getDataCombine(url: url, decodeTo: DetailsData.self) { [weak self] jsonData in
            DispatchQueue.main.async {
                self?.detailsData = jsonData
                self?.downloadPromoImage(imgString: jsonData.imageURL)
                self?.getPromoURL(details: jsonData)
            }
        }
    }
    
//    func getDetailsData() {
//        guard let movie = movie else { return }
//        let urlDeatilsId = "\(String(describing: movie.id)).txt"
//        let urlDetailsString = "\(URLManager.shared.urlDetailsBase)\(urlDeatilsId)"
//        guard let url = URL(string: urlDetailsString) else {return}
//        RequestManager.shared.getData(url: url, decodeTo: DetailsData.self) { [weak self] jsonDetails in
//            DispatchQueue.main.async {
//                self?.detailsData = jsonDetails
//                self?.downloadPromoImage(imgString: jsonDetails.imageURL)
//                self?.getPromoURL(details: jsonDetails)
//            }
//        }
//    }
    
    func getPromoURL(details: DetailsData) {
        guard let promoURL = URL(string: "\(String(describing: details.promoURL))") else {return}
        self.promoURL = promoURL
    }
    
    //MARK: - Download PromoImage
    func downloadPromoImage(imgString: String?) {
        guard let imgString = imgString else {return}
        var urlImageString: String = "\(imgString)"
        if !urlImageString.contains("https") {
            urlImageString = urlImageString.replacingOccurrences(of: "http", with: "https")
        }
        guard let urlDetailImage = URL(string: "\(urlImageString)") else {return}
        RequestManager.shared.downloadImage(url: urlDetailImage) { [weak self](data, error) in
            DispatchQueue.main.async {
                if let data = data {
                    let promoImage = Image(uiImage: UIImage(data: data) ?? UIImage())
                    self?.promoImage = promoImage
                } else {
                    print(NetworkManagerError.errorData)
                }
            }
        }
    }
}
