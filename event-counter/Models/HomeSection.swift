//
//  HomeSection.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 23/12/25.
//

import Foundation

enum HomeSection: String, CaseIterable, Identifiable {
    case future = "Futuro"
    case past = "Passado"

    var id: String { rawValue }
}
