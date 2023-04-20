//
//  MovieRentUIApp.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 12.04.2023.
//

import SwiftUI

@main
struct MovieRentUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LaunchView()
            }
            .statusBarHidden(true)
            
        }
    }
}
