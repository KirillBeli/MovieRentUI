//
//  ToolBarView.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 16.04.2023.
//

import SwiftUI

struct ToolBarView: View {
    
    typealias Completion = () -> Void
    let title: String
    let hidden: Bool
    let rightIcon: String
    let onTapLeft: Completion
    let onTapRight: Completion
    init(title: String, hidden: Bool, rightIcon: String,onTapLeft: @escaping Completion, onTapRight: @escaping Completion) {
        self.onTapLeft = hidden ? onTapLeft : onTapLeft
        self.onTapRight = onTapRight
        self.hidden = hidden
        self.rightIcon = rightIcon
        self.title = title
      }
    
    var body: some View {
        HStack {
            
            if !hidden {
                CircleButtonView(iconName: "chevron.left")
                    .onTapGesture(perform: onTapLeft )
            }
            CircleButtonView(iconName: "chevron.left").hidden()
            Spacer()//.frame(width: UIScreen.main.bounds.width * 0.39, height: 60)
            Text(LocalizedString.MoviesTitle.movies)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
            Spacer()
            CircleButtonView(iconName: rightIcon)
            .onTapGesture(perform: onTapRight)
        }
        .padding(.horizontal)
    }
}

struct ToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarView(title: "Movies", hidden: true, rightIcon: "heart", onTapLeft: {}, onTapRight: {})
            .previewLayout(.sizeThatFits)
    }
}
