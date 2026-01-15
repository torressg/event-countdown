import SwiftUI
import SwiftData

struct CountdownDetailView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var event: CountdownEvent
    
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CountdownCard(event: event)
                
                Toggle(isOn: Binding(
                                get: { event.hasNotification },
                                set: { newValue in
                                    event.hasNotification = newValue
                                    if newValue {
                                        NotificationManager.shared.scheduleNotification(for: event)
                                    } else {
                                        NotificationManager.shared.cancelNotification(for: event)
                                    }
                                }
                            )) {
                                HStack {
                                    Image(systemName: "bell.fill")
                                    Text("set_notification".localized)
                                }
                            }
                            .disabled(event.eventDate < Date())
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .glassEffect(.regular.tint(event.eventDate < Date() ? .gray : .green), in: .rect(cornerRadius: 10))
                            .opacity(event.eventDate < Date() ? 0.5 : 1.0)
                
                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("delete_event".localized)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                    )
                }
            }
            .padding()
        }
        .navigationTitle("event_details".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("done_button".localized) {
                    saveChanges()
                    dismiss()
                }
            }
        }
        .alert("delete_event_confirmation".localized, isPresented: $showDeleteConfirmation) {
            Button("cancel".localized, role: .cancel) {}
            Button("delete".localized, role: .destructive) {
                deleteEvent()
            }
        } message: {
            Text("delete_event_message".localized)
        }
    }
    
    private func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save changes: \(error)")
        }
    }
    
    private func deleteEvent() {
        if event.hasNotification {
            NotificationManager.shared.cancelNotification(for: event)
        }
        
        modelContext.delete(event)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to delete event: \(error)")
        }
    }
}
