//
//  NotificationSection.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct NotificationSection: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("set_notification".localized)
                .font(.headline)

            NotificationRow(type: "email".localized, value: "15")
            NotificationRow(type: "notification".localized, value: "30")
        }
    }
}

