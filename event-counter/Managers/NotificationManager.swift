import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func requestPermission() {
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                self.notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if let error = error {
                        print("Error requesting notification permission: \(error)")
                    }
                }
            }
        }
    }
    
    func checkPermissionStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }
    
    func scheduleNotification(for event: CountdownEvent) {
        checkPermissionStatus { status in
            guard status == .authorized else {
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = event.title
            content.body = "notification_body".localized
            content.sound = .default
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: event.eventDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(
                identifier: event.id.uuidString,
                content: content,
                trigger: trigger
            )
            
            self.notificationCenter.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    }
    
    func cancelNotification(for event: CountdownEvent) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [event.id.uuidString])
    }
}
