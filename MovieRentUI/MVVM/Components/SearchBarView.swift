//
//  SearchBarView.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 14.04.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? .gray : .black)
            TextField("Search By Name...", text: $searchText)
                .foregroundColor(.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black)
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
                    
                    
                
        }
        .font(.headline)
        .padding()
        .background( RoundedRectangle(cornerRadius: 25)
            .fill(Color.gray.opacity(0.3)))
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
