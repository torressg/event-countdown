//
//  ResumoView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//


import SwiftUI

struct FutureView: View {
    var body: some View {
        HStack(spacing: 8){
            Text("Evento futuro")
                .font(.system(size: 16, weight: .medium))
        }.tint(.red)
    }
}

#Preview {
    ContentView()
}
