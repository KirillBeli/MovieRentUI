//
//  DetailsView.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 14.04.2023.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var detailsModel: DetailsViewModel = DetailsViewModel()
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                CenterView
                Description
            }
            .onAppear {
                detailsModel.movie = movie
                detailsModel.getDetails()
            }
        }
    }
}

extension DetailsView {
    
    private var CenterView: some View {
        
        VStack(alignment: .center, spacing: 30) {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.gray.opacity(0.3))
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.6)
                .shadow(color: .black, radius: 30, x: 5, y: 10)
                .overlay{
                    VStack(alignment: .center){
                        detailsModel.promoImage?
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .padding(.top, 10)
                        VStack(alignment: .center, spacing: 15) {
                            Text(detailsModel.detailsData?.name ?? "No data!!!!!")
                                .font(.title)
                                .padding(.leading, 5)
                            HStack {
                                Text("Year:")
                                Text(detailsModel.detailsData?.year ?? "No Year")
                            }
                            HStack {
                                Text("Category: ")
                                Text(detailsModel.detailsData?.category ?? "No Category")
                            }
                            HStack {
                                Text("Rate: ")
                                Text(detailsModel.detailsData?.rate ?? "No Rate")
                            }
                        }
                        .font(.headline)
                        .padding(.leading, 5)
                        
                        PromoLink
                        
                    }
                    .padding(.bottom, 10)
                    .padding(.trailing, 15)
                }
            }
        
        
        
        
    }
    
    private var PromoLink: some View {
        Link(destination: detailsModel.promoURL, label: {
            HStack(spacing: 3) {
                Image(systemName: "safari.fill")
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.leading, 10)
                Text("promoLink")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 30, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.25)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                
            }
            .background(Color.blue)
            .cornerRadius(25)
        })
    }
    
    private var Description: some View {
        VStack {
            Text("Description: ")
            Text(detailsModel.detailsData?.description ?? "No Description")
        }
        .font(.callout)
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(width: 350, height: 300, alignment: .top)
        .padding(5)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(movie: developer.movie)
    }
}
