//
//  event_counterApp.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 21/12/25.
//

import SwiftUI
import SwiftData

@main
struct event_counterApp: App {
    @StateObject private var languageManager = LanguageManager.shared
    
    init() {
        NotificationManager.shared.requestPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(languageManager)
        }
        .modelContainer(for: [CountdownEvent.self])
    }
}
