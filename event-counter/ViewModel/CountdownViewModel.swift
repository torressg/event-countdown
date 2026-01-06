import Foundation

class CountdownViewModel {

    let creationDate: Date

    init(creationDate: Date = Date()) {
        self.creationDate = creationDate
    }

    func differenceString(to eventDate: Date) -> String {
        let calendar = Calendar.current

        let start = calendar.startOfDay(for: creationDate)
        let end   = calendar.startOfDay(for: eventDate)

        let components = calendar.dateComponents(
            [.month, .day, .hour],
            from: start,
            to: end
        )

        let months = max(0, components.month ?? 0)
        let days   = max(0, components.day ?? 0)
        let hours  = max(0, components.hour ?? 0)

        return String(
            format: "%02d%02d%02d",
            months,
            days,
            hours
        )
    }
}