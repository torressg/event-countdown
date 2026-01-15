//
//  ResumoView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//


import SwiftUI
import SwiftData

struct FutureView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \CountdownEvent.eventDate, order: .forward)
    private var allEvents: [CountdownEvent]
    
    private var futureEvents: [CountdownEvent] {
        allEvents.filter { $0.eventType == "future" }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("your_events".localized)
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if futureEvents.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 60))
                            .foregroundStyle(.secondary)
                        
                        Text("no_future_events".localized)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
                } else {
                    ForEach(futureEvents) { event in
                        NavigationLink(destination: CountdownDetailView(event: event)) {
                            CountdownEventListCard(event: event)
                        }
                        .buttonStyle(.plain)
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

#Preview {
    ContentView()
        .environmentObject(LanguageManager.shared)
        .modelContainer(for: [CountdownEvent.self])
}
