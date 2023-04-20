//
//  AdvertisingView.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 13.04.2023.
//

import SwiftUI

struct AdvertisingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var launchModel: LaunchViewModel = LaunchViewModel()
    @State var backToList: Bool = false
    
    
    var body: some View {
        
        ZStack {
           AdverView
        }
        
        
//        if backToList {
//            HomeView()
//        } else {
//          AdverView
//        }
    }
}

extension AdvertisingView {
    private var AdverView: some View {
        ZStack {
            Color.theme.imageBackground.ignoresSafeArea()
            Rectangle()
                    .overlay {
                        launchModel.adImage?
                            .resizable()
                            .scaledToFill()
                    }
            .cornerRadius(20)
        }
    }
}

struct AdvertisingView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisingView()
    }
}
