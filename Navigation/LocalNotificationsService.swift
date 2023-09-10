//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Александр Филатов on 08.09.2023.
//

import Foundation
import UserNotifications

class LocalNotificationsService: NSObject, UNUserNotificationCenterDelegate {
    
    func registeForLatestUpdatesIfPossible() {
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
                
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                center.requestAuthorization(options: [.badge, .sound, .provisional, .alert]) { success, error in
                    if success {
                        self.dispatchNotification()
                    }
                    if let error {
                        print (error.localizedDescription)
                    }
                }
            default:
                    return
            }
        }
    }
        
    
    func dispatchNotification () {
        
        let id = "myNotifications"
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Посмотрите последние обновления"
        //content.categoryIdentifier = "updates"
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        center.removePendingNotificationRequests(withIdentifiers: [id])
        center.add(request)
    }
    
    
    
    /*func registerUpdatesCategory() {
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let actionUpdate = UNNotificationAction(identifier: "update", title: "Print", options: .destructive)
        let category = UNNotificationCategory(identifier: "updates", actions: [actionUpdate], intentIdentifiers: [])
        center.setNotificationCategories([category])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "update":
            print ("you pressed Update buttom")
        default:
            print ("default case pressed button")
        }
        completionHandler()
    
    }*/
    
}
