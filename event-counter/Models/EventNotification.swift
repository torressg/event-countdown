import Foundation
import SwiftData

@Model
final class EventNotification {
    var id: UUID
    var type: String
    var minutesBefore: Int
    var event: CountdownEvent?
    
    init(type: String, minutesBefore: Int) {
        self.id = UUID()
        self.type = type
        self.minutesBefore = minutesBefore
    }
}

