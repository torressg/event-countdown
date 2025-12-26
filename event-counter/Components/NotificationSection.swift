//
//  NotificationSection.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct NotificationSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Set a notification")
                .font(.headline)

            NotificationRow(type: "Email", value: "15")
            NotificationRow(type: "Notification", value: "30")
        }
    }
}

