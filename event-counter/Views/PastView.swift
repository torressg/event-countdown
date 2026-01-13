//
//  EventosView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//


import SwiftUI
import SwiftData

struct PastView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \CountdownEvent.eventDate, order: .reverse)
    private var allEvents: [CountdownEvent]
    
    private var pastEvents: [CountdownEvent] {
        let now = Date()
        return allEvents.filter { $0.eventDate < now }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("past_events".localized)
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if pastEvents.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "calendar.badge.checkmark")
                            .font(.system(size: 60))
                            .foregroundStyle(.secondary)
                        
                        Text("no_past_events".localized)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
                } else {
                    ForEach(pastEvents) { event in
                        CountdownCard(event: event)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deleteEvent(event)
                                } label: {
                                    Label("delete_event".localized, systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .padding()
        }
    }
    
    private func deleteEvent(_ event: CountdownEvent) {
        modelContext.delete(event)
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete event: \(error)")
        }
    }
}
