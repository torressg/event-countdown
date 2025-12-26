//
//  FlipNumber.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 26/12/25.
//


import SwiftUI

struct FlipNumber: View {
    let value: Int

    @State private var previousValue: Int = 0
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))

            Text(String(format: "%02d", value))
                .font(.system(size: 36, weight: .bold, design: .monospaced))
                .foregroundStyle(.green)
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 1, y: 0, z: 0),
                    perspective: 0.7
                )
        }
        .frame(width: 80, height: 90)
        .onChange(of: value) { newValue in
            animateFlip()
        }
    }

    private func animateFlip() {
        rotation = 0
        withAnimation(.easeIn(duration: 0.15)) {
            rotation = -90
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.easeOut(duration: 0.15)) {
                rotation = -180
            }
        }
    }
}