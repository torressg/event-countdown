//
//  CountdownViewModel.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 26/12/25.
//


import Foundation

class CountdownViewModel {

    let creationDate: Date

    init(creationDate: Date = Date()) {
        self.creationDate = creationDate
    }

    func differenceString(to eventDate: Date) -> String {
        let calendar = Calendar.current

        let components = calendar.dateComponents(
            [.month, .day, .hour, .minute, .second],
            from: Date(),
            to: eventDate
        )

        let months = max(0, components.month ?? 0)
        var days   = max(0, components.day ?? 0)
        var hours  = max(0, components.hour ?? 0)
        var minutes = max(0, components.minute ?? 0)
        let seconds = max(0, components.second ?? 0)
        
        if seconds > 0 {
            minutes += 1
            if minutes >= 60 {
                minutes = 0
                hours += 1
                if hours >= 24 {
                    hours = 0
                    days += 1
                }
            }
        }

        return String(
            format: "%02d%02d%02d%02d",
            months,
            days,
            hours,
            minutes
        )
    }
}