//
//  SettingsView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//


import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("language_setting".localized, selection: $languageManager.currentLanguage) {
                        ForEach(AppLanguage.allCases, id: \.self) { language in
                            Text(language.displayName).tag(language)
                        }
                    }
                } header: {
                    Text("language_setting".localized)
                }
            }
            .navigationTitle("settings_title".localized)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LanguageManager.shared)
}