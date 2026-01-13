//
//  NotificationRow.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 25/12/25.
//

import SwiftUI

struct NotificationRow: View {
    let type: String
    let value: String
    var onDelete: () -> Void

    var body: some View {
        HStack(spacing: 8) {

            Text(type)
                .frame(width: 100)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(0.3)))

            Text(value)
                .frame(width: 50)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(0.3)))

            Text("Mins.")
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(0.3)))

            Button {
                onDelete()
            } label: {
                Image(systemName: "xmark")
                    .padding(8)
            }
        }
        .foregroundStyle(.secondary)
    }
}
