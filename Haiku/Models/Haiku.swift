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

/*
 {
     "id": "chatcmpl-wnah36uhmhft1iiew9zyib",
     "object": "chat.completion",
     "created": 1745869016,
     "model": "qvq-step-tiny",
     "choices": [
         {
             "index": 0,
             "logprobs": null,
             "finish_reason": "stop",
             "message": {
                 "role": "assistant",
                 "content": "Golden retriever lying down,\nNature's peaceful ambiance.\nIn the woods, he rests serene."
             }
         }
     ],
     "usage": {
         "prompt_tokens": 32,
         "completion_tokens": 19,
         "total_tokens": 51
     },
     "stats": {},
     "system_fingerprint": "qvq-step-tiny"
 }
 */


