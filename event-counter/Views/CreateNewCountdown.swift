//
//  CreateNewCountdown.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct CreateNewCountdownView: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
            ScrollView {
                VStack(spacing: 24) {

                    CountdownCard()

                    NotificationSection()

                    Spacer(minLength: 40)

                    Button("create_button".localized) {}
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
        }}
