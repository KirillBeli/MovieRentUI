//
//  HomeViewModel.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 14.04.2023.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @ObservedObject var launchModel: LaunchViewModel = LaunchViewModel()
    @Published var filteredMovies: [Movie] = []
    @Published var searchText: String = ""
    @Published var title: String = LocalizedString.MoviesTitle.movies
    private var cancellables: Set<AnyCancellable> = []
    let localized = LocalizedString.MoviesTitle.self
    
    init() {
        
        performSearch()
    }
    
    
    func performSearch() {
        
        $searchText
            .combineLatest(launchModel.$moviesResult)
            .map { (text, startingMovies) -> [Movie] in
                guard !text.isEmpty else { return startingMovies }
                let lowercasedText = text.lowercased()
                return startingMovies.filter { movie in
                    return movie.name.lowercased().contains(lowercasedText) ||
                    movie.category.lowercased().contains(lowercasedText)
                }
            }
            .sink { [weak self] returedMovies in
                self?.filteredMovies = returedMovies
            }
            .store(in: &cancellables)
    }
    
    func getActionSheet() -> ActionSheet {
        
        let categoryLowercase = LocalizedString.MoviesFilter.self
        let title = Text("Filter")
        let message = Text("Choose the category")
        
        let actionButton: ActionSheet.Button = .default(Text(localized.action)) {
            self.filteredMovies = self.launchModel.moviesResult.filter { [weak self] (movie) in
                self?.title = self?.localized.action ?? ""
                return movie.category.lowercased().contains(categoryLowercase.action)
            }
        }
        let comedyButton: ActionSheet.Button = .default(Text(localized.comedy)) {
            self.filteredMovies = self.launchModel.moviesResult.filter { [weak self] (movie) in
                self?.title = self?.localized.comedy ?? ""
                return movie.category.lowercased().contains(categoryLowercase.comedy)
            }
        }
        let crimeButton: ActionSheet.Button = .default(Text(localized.crime)) {
            self.filteredMovies = self.launchModel.moviesResult.filter { [weak self] (movie) in
                self?.title = self?.localized.crime ?? ""
                return movie.category.lowercased().contains(categoryLowercase.crime)
            }
        }
        let dramaButton: ActionSheet.Button = .default(Text(localized.drama)) {
            self.filteredMovies = self.launchModel.moviesResult.filter { [weak self] (movie) in
                self?.title = self?.localized.drama ?? ""
                return movie.category.lowercased().contains(categoryLowercase.drama)
            }
        }
        let fantasyButton: ActionSheet.Button = .default(Text(localized.fantasy)) {
            self.filteredMovies = self.launchModel.moviesResult.filter { [weak self] (movie) in
                self?.title = self?.localized.fantasy ?? ""
                return movie.category.lowercased().contains(categoryLowercase.fantasy)
            }
        }
        let allMoviesButton: ActionSheet.Button = .default(Text(localized.movies)) {
            self.title = self.localized.movies
            self.filteredMovies = self.launchModel.moviesResult
        }
        let cancelButton: ActionSheet.Button = .cancel()
        
        return ActionSheet(title: title, message: message, buttons: [actionButton, comedyButton, crimeButton, dramaButton, fantasyButton, allMoviesButton, cancelButton])
    }
    
}
