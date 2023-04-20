//
//  CellView.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 16.04.2023.
//

import SwiftUI

struct CellView: View {
    
//    let index: Int
    let movie: Movie
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(movie.name)
                    .font(.headline)
                    .foregroundColor(.theme.accent)
                Text(movie.id)
                    .font(.caption)
                    .foregroundColor(.theme.SecondaryText)
                    .frame(alignment: .leading)
            }
            .frame(alignment: .leading)
            Spacer()
//            NavigationLink {
//                DetailsView(index: index)
//            } label: {
//                VStack(alignment: .leading){
//                    Text(movie.name)
//                        .font(.headline)
//                        .foregroundColor(.theme.accent)
//                    Text(movie.id)
//                        .font(.caption)
//                        .foregroundColor(.theme.SecondaryText)
//                        .frame(alignment: .leading)
//                }
//                .frame(alignment: .leading)
//            }
//            Spacer()
        }
        .padding(15)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
        .background(Color.theme.background)
        .cornerRadius(10)
        .shadow(radius: 15)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(movie: developer.movie)
            .previewLayout(.sizeThatFits)
    }
}
