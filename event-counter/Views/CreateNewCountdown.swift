//
//  CreateNewCountdown.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct CreateNewCountdownView: View {
    var body: some View {
            ScrollView {
                VStack(spacing: 24) {

                    // Countdown Card
                    CountdownCard()

                    // Notification Section
                    NotificationSection()

                    Spacer(minLength: 40)

                    Button("Create") {}
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
            .navigationTitle("Countdown to")
            .navigationBarTitleDisplayMode(.inline)
        }}
