//
//  HaikuGenerator.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import Foundation

enum NetworkError: Swift.Error {
    case badURL
    case invalidResponse
    case invalidResponseStatusCode(Int)
    case invalidData
    case failedParsingJson(String)
    
    var description: String {
        switch self {
        case .badURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .invalidResponseStatusCode(let responseCode):
            return "Invalid response status code: \(responseCode)"
        case .invalidData:
            return "Invalid Data"
        case .failedParsingJson(let description):
            return "Unable to decode Json data: \(description)"
        }
    }
}

protocol HaikuGenerator {
    func generateHaiku(base64ImageData: String) async throws -> String
}
