import SwiftUI
import SwiftData

struct CountdownEventListCard: View {
    @EnvironmentObject var languageManager: LanguageManager
    let event: CountdownEvent
    
    @StateObject private var countdownViewModel: CountdownClockViewModel
    
    init(event: CountdownEvent) {
        self.event = event
        self._countdownViewModel = StateObject(wrappedValue: CountdownClockViewModel(targetDate: event.eventDate))
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = languageManager.currentLocale
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: event.eventDate)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                
                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CountdownClockView(viewModel: countdownViewModel)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

struct ElapsedTimeView: View {
    let elapsedTime: ElapsedTime
    
    var body: some View {
        HStack(spacing: 8) {
            TimeBlockElapsed(value: elapsedTime.days, label: "elapsed_days_label".localized)
            TimeBlockElapsed(value: elapsedTime.hours, label: "elapsed_hours_label".localized)
            TimeBlockElapsed(value: elapsedTime.minutes, label: "elapsed_minutes_label".localized)
            TimeBlockElapsed(value: elapsedTime.seconds, label: "elapsed_seconds_label".localized)
        }
    }
}

struct TimeBlockElapsed: View {
    let value: Int
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(String(format: "%02d", value))
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.tertiarySystemBackground))
        )
    }
}
