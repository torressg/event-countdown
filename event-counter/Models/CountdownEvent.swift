import Foundation
import SwiftData

@Model
final class CountdownEvent {
    @Attribute(.unique) var id: UUID
    var title: String
    var eventDate: Date
    var createdAt: Date
    var eventType: String = "future"
    var hasNotification: Bool = false
    
    @Relationship(deleteRule: .cascade,)
    
    init(title: String, eventDate: Date, hasNotification: Bool = false) {
        self.id = UUID()
        self.title = title
        self.eventDate = eventDate
        self.hasNotification = hasNotification
        let now = Date()
        self.createdAt = now
        self.eventType = eventDate < now ? "past" : "future"
    }
    
    var isPast: Bool {
        eventDate < Date()
    }
}

