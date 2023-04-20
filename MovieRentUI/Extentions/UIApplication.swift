//
//  UIApplicationExtension.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 14.04.2023.
//

import Foundation
import SwiftUI

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
