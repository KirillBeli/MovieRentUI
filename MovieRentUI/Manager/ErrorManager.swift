//
//  ErrorManager.swift
//  MovieRentUI
//
//  Created by Kyrylo Bielykov on 12.04.2023.
//

import Foundation

enum NetworkManagerError: Error {
    case errorResponse(URLResponse?)
    case errorLocalUrl
    case errorData
    
    var errorDescription: String? {
        switch self {
        case .errorResponse:
            return "Error Response"
        case .errorLocalUrl:
            return "Error Local URL"
        case .errorData:
            return "Error Data"
        }
    }
}


