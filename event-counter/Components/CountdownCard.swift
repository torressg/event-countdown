//
//  CountdownCard.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI
import SwiftData

struct CountdownCard: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.modelContext) private var modelContext
    
    var event: CountdownEvent?
    var title: Binding<String>?
    var date: Binding<Date>?
    
    @State private var isRenaming = false
    @FocusState private var isTitleFocused: Bool
    @State private var tempDate: Date = Date()
    @State private var showDatePicker = false
    
    @StateObject private var countdownClockVM: CountdownClockViewModel
    
    init(event: CountdownEvent) {
        self.event = event
        self.title = nil
        self.date = nil
        self._countdownClockVM = StateObject(wrappedValue: CountdownClockViewModel(targetDate: event.eventDate))
    }
    
    init(title: Binding<String>, date: Binding<Date>) {
        self.event = nil
        self.title = title
        self.date = date
        let initialDate = date.wrappedValue
        self._countdownClockVM = StateObject(wrappedValue: CountdownClockViewModel(targetDate: initialDate))
    }
    
    private var displayTitle: String {
        if let event = event {
            return event.title
        } else if let title = title {
            return title.wrappedValue
        }
        return "new_countdown_name".localized
    }
    
    private var displayDate: Date {
        if let event = event {
            return event.eventDate
        } else if let date = date {
            return date.wrappedValue
        }
        return Date()
    }
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = languageManager.currentLocale
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: displayDate)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            VStack(alignment: .leading, spacing: 4) {

                HStack {
                    if isRenaming, let titleBinding = getEditableTitle() {
                        TextField("countdown_name_placeholder".localized, text: titleBinding)
                            .textFieldStyle(.plain)
                            .focused($isTitleFocused)
                            .onSubmit {
                                finishRename()
                            }
                    } else {
                        Text(displayTitle)
                            .font(.headline)
                    }

                    RenameButton()
                        .renameAction {
                            startRename()
                        }
                        .tint(.green)
                }

                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .onTapGesture {
                        tempDate = displayDate
                        showDatePicker = true
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CountdownClockView(viewModel: countdownClockVM)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
        .sheet(isPresented: $showDatePicker, onDismiss: {
            if let event = event {
                event.eventDate = tempDate
            } else if let date = date {
                date.wrappedValue = tempDate
            }
            countdownClockVM.targetDate = tempDate
            countdownClockVM.updateCountdown()
        }) {
            NavigationStack {
                VStack(spacing: 16) {

                    DatePicker(
                        "select_date".localized,
                        selection: $tempDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)

                    Spacer()
                }
                .padding()
                .navigationTitle("select_date_title".localized)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("done_button".localized) {
                            showDatePicker = false
                        }
                    }
                }
            }
        }
    }
    
    private func getEditableTitle() -> Binding<String>? {
        if let event = event {
            return Binding(
                get: { event.title },
                set: { event.title = $0 }
            )
        } else {
            return title
        }
    }
    
    private func startRename() {
        isRenaming = true
        DispatchQueue.main.async {
            isTitleFocused = true
        }
    }

    private func finishRename() {
        isRenaming = false
    }
}
