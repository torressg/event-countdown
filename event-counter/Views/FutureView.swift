//
//  ResumoView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//


import SwiftUI

struct FutureView: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("your_events".localized)
                .font(.system(size: 24, weight: .bold))
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(LanguageManager.shared)
}
