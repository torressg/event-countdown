//
//  CountdownViewModel.swift
//  event-counter
//
//  Created by Guilherme Torres Vanderlei on 26/12/25.
//


import Foundation

class CountdownViewModel {

    func differenceString(to eventDate: Date) -> String {
        let calendar = Calendar.current

        let (fromDate, toDate) = eventDate < Date() 
            ? (eventDate, Date()) 
            : (Date(), eventDate)
        
        let components = calendar.dateComponents(
            [.month, .day, .hour, .minute, .second],
            from: fromDate,
            to: toDate
        )

        let months = components.month ?? 0
        var days   = components.day ?? 0
        var hours  = components.hour ?? 0
        var minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
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