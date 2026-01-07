//
//  HomeView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//


import SwiftUI

struct HomeView: View {
    @State private var selectedSection: HomeSection = .future
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            
            VStack(spacing: 16) {
                
                Picker("section_picker_label".localized, selection: $selectedSection) {
                    ForEach(HomeSection.allCases) { section in
                        Text(section.displayName).tag(section)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                contentView
                Spacer()
            }
            
            
            NewCountdownButton()
            .padding()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch selectedSection {
        case .past:
            PastView()
        case .future:
            FutureView()
        }
    }
}
