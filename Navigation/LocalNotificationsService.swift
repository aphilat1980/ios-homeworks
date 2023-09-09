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
        center.requestAuthorization(options: [.badge, .sound, .provisional, .alert]) { success, error in
            if let error {
                print (error.localizedDescription)}
        }
       
        // registerUpdatesCategory()
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Посмотрите последние обновления"
        //content.categoryIdentifier = "updates"
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
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
