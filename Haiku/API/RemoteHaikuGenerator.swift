//
//  RemoteHaikuGenerator.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import Foundation

class RemoteHaikuGenerator: HaikuGenerator {
    
    
    
    private var apiKey: String
    private var endpoint: URL
    private var model: String
    
    init(apiKey: String,
         endpoint: URL = URL(string: "https://api.openai.com/v1/engines/text-davinci-003/completions")!,
         model: String = "qvq-step-tiny") {
        self.apiKey = apiKey
        self.endpoint = endpoint
        self.model = model
    }
    
    func makeRequestBody(base64ImageData: String) throws -> Data {
        let requestBody: [String: Any] = [
            "model": "\(self.model)",
            "temperature": 1.2,
            "messages": [
                ["role": "user",
                 "content": [
                    ["type": "text", "text": "Make a haiku poem based on the provided picture"],
                    [
                        "type": "image_url",
                        "image_url": [
                            "url": "data:image/jpeg;base64,\(base64ImageData)"
                        ]
                    ],
                 ]
                ]
            ],
            "max_tokens": 1000,
            "stream": false
        ]
        
        return try JSONSerialization.data(withJSONObject: requestBody, options: [])
    }
    
    func generateHaiku(base64ImageData: String) async throws -> String {
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try makeRequestBody(base64ImageData: base64ImageData)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponseStatusCode(httpResponse.statusCode)
        }
        
        do {
            let haiku = try JSONDecoder().decode(Haiku.self, from: data)
            return haiku.content ?? ""
        } catch {
            throw NetworkError.failedParsingJson(error.localizedDescription)
        }
    }
}
