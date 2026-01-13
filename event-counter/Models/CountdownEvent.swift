import Foundation
import SwiftData

@Model
final class CountdownEvent {
    @Attribute(.unique) var id: UUID
    var title: String
    var eventDate: Date
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade,)
    
    init(title: String, eventDate: Date) {
        self.id = UUID()
        self.title = title
        self.eventDate = eventDate
        self.createdAt = Date()
    }
    
    var isPast: Bool {
        eventDate < Date()
    }
}

