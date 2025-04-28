//
//  HaikuGenerator.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import Foundation

enum NetworkError: Swift.Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case failedParsingJSON(String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .invalidStatusCode(let responseCode):
            return "Invalid response status code: \(responseCode)"
        case .failedParsingJSON(let description):
            return "Unable to decode Json data: \(description)"
        }
    }
}

protocol HaikuGenerator {
    func generateHaiku(base64ImageData: String) async throws -> String
}
