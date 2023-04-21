//
//  RequestManager.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 12.04.2023.
//

import SwiftUI
import Combine

class RequestManager {
    
    static let shared = RequestManager()
    private init() { }
    
    //MARK: - Properties
    var session = URLSession.shared
    let decoder = JSONEncoder()
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Get Data
    func getDataCombine<T: Codable>(url: URL, decodeTo: T.Type, completion: @escaping (T) -> ()) {
        session.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: decodeTo, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished: print("")
                case .failure(let error):
                    print("There was an error: \(error)")
                }
            } receiveValue: { returnedData in
                completion(returnedData)
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Status Code Handle
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { throw URLError(.badServerResponse) }
        return output.data
    }
    
}
