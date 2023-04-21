//
//  HomeView.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 13.04.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var launchModel: LaunchViewModel = LaunchViewModel()
    @ObservedObject private var homeModel: HomeViewModel = HomeViewModel()
    
    
    var body: some View {
        
        ZStack{
            if launchModel.firstTimeOpen {
                AdvertisingView()
                    .animation(.spring(), value: launchModel.firstTimeOpen)
            } else {
                BuildedHome
            }
        }
        .actionSheet(isPresented: homeModel.$showSheet, content: homeModel.getActionSheet)
        .onAppear {
            TimeManager.shared.delay(seconds: 3) {
                self.launchModel.firstTimeOpen = false
            }
        }
    }
}

extension HomeView {
    
    private var BuildedHome: some View {
        ZStack {
            VStack {
                ToolBarView(title: homeModel.title, hidden: true, rightIcon: "line.3.horizontal.decrease.circle.fill") {} onTapRight: {
                    homeModel.showSheet.toggle()
                }
                SearchBarView(searchText: $homeModel.searchText)
                MovieList
            }
        }
    }
    
    private var MovieList: some View {
        List {
            ForEach(homeModel.filteredMovies) { movie in
                NavigationLink {
                    DetailsView(movie: movie)
                } label: {
                    CellView(movie: movie)
                        .padding()
                }
            }
        }
        .listStyle(.plain)
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




