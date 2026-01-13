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
                
                Spacer(minLength: 40)
                
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
                            .fill(Color.red.opacity(0.35))
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
        modelContext.delete(event)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to delete event: \(error)")
        }
    }
}
