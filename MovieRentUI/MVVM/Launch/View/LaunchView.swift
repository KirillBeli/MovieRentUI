//
//  LaunchView.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 12.04.2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State var timerDone: Bool = false
    
    var body: some View {
        if timerDone {
            HomeView()
        } else {
           LaunchImage
        }
    }
}

extension LaunchView {
    
    private var LaunchImage: some View {
        ZStack {
            Color.theme.imageBackground.ignoresSafeArea()
            VStack {
                Image("Cinema")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.accentColor)
                Text("Made by Kirill Belikov")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .onAppear {
            TimeManager.shared.delay(seconds: 5) {
                self.timerDone = true
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
