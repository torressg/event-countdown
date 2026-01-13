//
//  NotificationSection.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct NotificationSection: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Binding var notifications: [EventNotification]
    
    @State private var showAddNotification = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text("set_notification".localized)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    addNotification()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.green)
                }
            }

            ForEach(notifications.indices, id: \.self) { index in
                NotificationRow(
                    type: notifications[index].type,
                    value: String(notifications[index].minutesBefore),
                    onDelete: {
                        notifications.remove(at: index)
                    }
                )
            }
        }
    }
    
    private func addNotification() {
        let newNotification = EventNotification(type: "notification", minutesBefore: 15)
        notifications.append(newNotification)
    }
}

