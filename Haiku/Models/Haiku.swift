//
//  Haiku.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import Foundation

struct Haiku: Decodable {

    let choices: [Choice]
    var content: String? {
        choices.first?.message.content
    }
    
    struct Choice: Decodable {
        let message: Message
        
        struct Message: Decodable {
            let content: String
        }
    }
}




