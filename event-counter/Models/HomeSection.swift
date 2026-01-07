//
//  HomeSection.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//

import Foundation

enum HomeSection: String, CaseIterable, Identifiable {
    case future
    case past

    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .future:
            return "section_future".localized
        case .past:
            return "section_past".localized
        }
    }
}
