//
//  Color.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 16.04.2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let SecondaryText = Color("SecondaryTextColor")
    let imageBackground = Color("ImageBackground")
}
