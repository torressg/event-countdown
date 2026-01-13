import Foundation
import SwiftData

@Model
final class CountdownEvent {
    @Attribute(.unique) var id: UUID
    var title: String
    var eventDate: Date
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \EventNotification.event)
    var notifications: [EventNotification]
    
    init(title: String, eventDate: Date, notifications: [EventNotification] = []) {
        self.id = UUID()
        self.title = title
        self.eventDate = eventDate
        self.createdAt = Date()
        self.notifications = notifications
    }
    
    var isPast: Bool {
        eventDate < Date()
    }
}

