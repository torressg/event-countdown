//
//  HomeView.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//


import SwiftUI

struct HomeView: View {
    @State private var selectedSection: HomeSection = .future
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            
            VStack(spacing: 16) {
                
                Picker("Seção", selection: $selectedSection) {
                    ForEach(HomeSection.allCases) { section in
                        Text(section.rawValue).tag(section)
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
