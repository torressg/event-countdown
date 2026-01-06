//
//  CountdownCard.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct CountdownCard: View {
    
    @State private var countdownTitle = "Next friday"
    @State private var isRenaming = false
    @FocusState private var isTitleFocused: Bool
    
    @State private var countdownDate: Date = {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysUntilFriday = (6 - weekday + 7) % 7
        let nextFriday = calendar.date(byAdding: .day, value: daysUntilFriday == 0 ? 7 : daysUntilFriday, to: today) ?? today
        return calendar.startOfDay(for: nextFriday)
    }()
    @State private var tempDate: Date = Date()
    @State private var showDatePicker = false
    
    @StateObject private var countdownClockVM: CountdownClockViewModel = {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysUntilFriday = (6 - weekday + 7) % 7
        let nextFriday = calendar.date(byAdding: .day, value: daysUntilFriday == 0 ? 7 : daysUntilFriday, to: today) ?? today
        let initialDate = calendar.startOfDay(for: nextFriday)
        return CountdownClockViewModel(targetDate: initialDate)
    }()
    private var formattedDate: String {
        countdownDate.formatted(
            date: .long,
            time: .shortened
        )
    }
    
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Title + Edit
            VStack(alignment: .leading, spacing: 4) {

                HStack {
                    if isRenaming {
                        TextField("Countdown name", text: $countdownTitle)
                            .textFieldStyle(.plain)
                            .focused($isTitleFocused)
                            .onSubmit {
                                finishRename()
                            }
                    } else {
                        Text(countdownTitle)
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
                        tempDate = countdownDate
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
            countdownDate = tempDate
            countdownClockVM.targetDate = tempDate
            countdownClockVM.updateCountdown()
        }) {
            NavigationStack {
                VStack(spacing: 16) {

                    DatePicker(
                        "Select date",
                        selection: $tempDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)

                    Spacer()
                }
                .padding()
                .navigationTitle("Select Date")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            showDatePicker = false
                        }
                    }
                }
            }
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
