//
//  ContentView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 21/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("tab_home".localized, systemImage: "house")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("tab_settings".localized, systemImage: "gear")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LanguageManager.shared)
}
