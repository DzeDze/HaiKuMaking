//
//  HaikuApp.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import SwiftUI

@main
struct HaikuApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(haikuGenerator: RemoteHaikuGenerator(urlString: "https://7474-198-84-224-217.ngrok-free.app/v1/chat/completions"))
        }
    }
}
