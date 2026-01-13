//
//  CreateNewCountdown.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI
import SwiftData

struct CreateNewCountdownView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var eventTitle: String = ""
    @State private var eventDate: Date = {
        Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    }()
    
    var body: some View {
            ScrollView {
                VStack(spacing: 24) {

                    CountdownCard(title: $eventTitle, date: $eventDate)

                    Spacer(minLength: 40)

                    Button("create_button".localized) {
                        saveEvent()
                    }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green.opacity(0.35))
                        )
                        .glassEffect(.regular.tint(.green).interactive(), in: .rect(cornerRadius: 10))
                }
                .padding()
            }
            .navigationTitle("countdown_to_title".localized)
            .navigationBarTitleDisplayMode(.inline)
        }
    
    private func saveEvent() {
        let newEvent = CountdownEvent(
            title: eventTitle.isEmpty ? "New Event" : eventTitle,
            eventDate: eventDate,
        )
        
        modelContext.insert(newEvent)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save event: \(error)")
        }
    }
}
