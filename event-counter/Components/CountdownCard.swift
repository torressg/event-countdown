//
//  CountdownCard.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct CountdownCard: View {
    
    @State private var countdownTitle = "Countdown name"
    @State private var isRenaming = false
    @FocusState private var isTitleFocused: Bool
    @State private var countdownDate = Date()
    @State private var showDatePicker = false
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
                        finishRename()
                        showDatePicker = true
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // Time Blocks
            HStack(spacing: 12) {
                FlipNumber(value: 4)
                FlipNumber(value: 23)
                FlipNumber(value: 43)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
        .sheet(isPresented: $showDatePicker) {
            NavigationStack {
                VStack(spacing: 16) {

                    DatePicker(
                        "Select date",
                        selection: $countdownDate,
                        displayedComponents: [.date]
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
