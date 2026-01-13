import Foundation
import Combine

struct ElapsedTime {
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    var formattedString: String {
        String(format: "%02d%02d%02d%02d", days, hours, minutes, seconds)
    }
}

class ElapsedTimeViewModel: ObservableObject {
    @Published var elapsedTime: ElapsedTime = ElapsedTime(days: 0, hours: 0, minutes: 0, seconds: 0)
    
    let eventDate: Date
    private var cancellables = Set<AnyCancellable>()
    
    init(eventDate: Date) {
        self.eventDate = eventDate
        setupTimer()
        updateElapsedTime()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setupTimer() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime()
            }
            .store(in: &cancellables)
    }
    
    private func updateElapsedTime() {
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day, .hour, .minute, .second],
            from: eventDate,
            to: Date()
        )
        
        let days = max(0, components.day ?? 0)
        let hours = max(0, components.hour ?? 0)
        let minutes = max(0, components.minute ?? 0)
        let seconds = max(0, components.second ?? 0)
        
        elapsedTime = ElapsedTime(days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
}
