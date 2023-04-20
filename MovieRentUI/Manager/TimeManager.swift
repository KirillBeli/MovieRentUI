//
//  TimeManager.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 20.04.2023.
//

import Foundation
import SwiftUI

class TimeManager {
    
    static let shared = TimeManager()
    
    func delay(seconds: CGFloat, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
}
