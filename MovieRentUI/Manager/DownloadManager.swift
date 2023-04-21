//
//  DownloadManager.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 21.04.2023.
//

import Foundation
import SwiftUI
import Combine

class DownloadManager {
    
    static let shared = DownloadManager()
    private init() { }
    
    //MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Download Image
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print(NetworkManagerError.errorResponse)
            } receiveValue: {  returnedImage in
                completion(returnedImage)
            }
            .store(in: &cancellables)
    }
}
