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
    
    @State private var eventTitle: String = "new_countdown_name".localized
    @State private var eventDate: Date = Date()
    @State private var showTitleRequiredAlert = false
    @State private var enableNotification: Bool = false
    
    var body: some View {
            ScrollView {
                VStack(spacing: 24) {

                    CountdownCard(title: $eventTitle, date: $eventDate)

                    Toggle(isOn: $enableNotification) {
                        HStack {
                            Image(systemName: "bell.fill")
                            Text("set_notification".localized)
                        }
                    }
                    .disabled(eventDate < Date())
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .glassEffect(.regular.tint(eventDate < Date() ? .gray : .green), in: .rect(cornerRadius: 10))
                    .opacity(eventDate < Date() ? 0.5 : 1.0)

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
            .onChange(of: eventDate) { oldValue, newValue in
                    if newValue < Date() {
                        enableNotification = false
                    }
                }
            .navigationTitle("new_event_title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .alert("error_title_required".localized, isPresented: $showTitleRequiredAlert) {
                Button("done_button".localized, role: .cancel) {}
            } message: {
                Text("error_title_required_message".localized)
            }
        }
    
    private func saveEvent() {
        guard !eventTitle.isEmpty else {
            showTitleRequiredAlert = true
            return
        }
        
        let newEvent = CountdownEvent(
            title: eventTitle,
            eventDate: eventDate,
            hasNotification: enableNotification
        )
        
        modelContext.insert(newEvent)
        
        do {
            try modelContext.save()
            
            if enableNotification {
                NotificationManager.shared.scheduleNotification(for: newEvent)
            }
            
            dismiss()
        } catch {
            print("Failed to save event: \(error)")
        }
    }
}
