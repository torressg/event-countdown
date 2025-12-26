//
//  NewCountdownButton.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 24/12/25.
//

import SwiftUI

struct NewCountdownButton: View {
    @State private var showCreateNewCountdown = false

    var body: some View {
        Button {
            showCreateNewCountdown = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "timer")
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(6)
                                    .background(
                                        Circle()
                                            .fill(.primary.opacity(0.2))
                                    )


                Text("New Countdown")
                    .font(.system(size: 16, weight: .medium))
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 6)
        }
        .buttonStyle(.glassProminent)
        .tint(.green)
        .sheet(isPresented: $showCreateNewCountdown) {
                    NavigationStack {
                        CreateNewCountdownView()
                    }
                }
    }
}

#Preview {
    ContentView()
}
