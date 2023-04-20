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
    var session = URLSession.shared
    let decoder = JSONEncoder()
    var cancellables = Set<AnyCancellable>()
    
    func getDataCombine<T: Codable>(url: URL, decodeTo: T.Type, completion: @escaping (T) -> ()) {
        session.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: decodeTo, decoder: JSONDecoder())
//            .replaceError(with: nil)
            .sink { (completion) in
                switch completion {
                case .finished: print("finished")
                case .failure(let error):
                    print("There was an error: \(error)")
                }
            } receiveValue: { returnedData in
                completion(returnedData)
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { throw URLError(.badServerResponse) }
        return output.data
    }
    
    func getData<T: Codable>(url: URL, decodeTo: T.Type, completion: @escaping (T)->()) {
        let session = URLSession.shared
        session.dataTask(with: url) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    guard let jsonData = jsonData else {return}
                    let jsonDetails = try JSONDecoder().decode(T.self, from: jsonData)
                    self.decoder.outputFormatting = .prettyPrinted
                    completion(jsonDetails)
                } catch {
                    print("parse error \(error)")
                }
            }
        }.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        let configur = URLSessionConfiguration.default
        session = URLSession(configuration: configur)
        let _: Void = session.downloadTask(with: url) { url, response, error in
            if error != nil {
                completion(nil, NetworkManagerError.errorData)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { completion(nil, NetworkManagerError.errorResponse(response))
                return
            }
            guard let url = url else { completion(nil, NetworkManagerError.errorLocalUrl)
                return
            }
            do{
                let data = try Data(contentsOf: url)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}
