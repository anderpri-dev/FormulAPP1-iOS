//
//  NotificationHelper.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//


import UserNotifications

class NotificationHelper {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }
    
    static func sendFetchNotification() {
        let content = UNMutableNotificationContent()
        
        // Obtener el lenguaje seleccionado del usuario
        let selectedLanguage = UserPreferencesManager.shared.getLanguage() ?? "system"
        let languageCode = selectedLanguage == "system" ? Locale.current.language.languageCode?.identifier ?? "en" : selectedLanguage
        
        content.title = localizedString("noti.title", languageCode: languageCode)
        content.body = localizedString("noti.body", languageCode: languageCode)
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        )
        UNUserNotificationCenter.current().add(request)
    }
    
    // Obligatorio usar NSLocalizedString porque no estamos usando SwiftUI
    // Por lo tanto -> Hay que construir una función auxiliar para que sincronice el idioma de la notificación
    private static func localizedString(_ key: String, languageCode: String) -> String {
        return LocalizedStringManager.shared.localizedString(key, languageCode: languageCode)
    }
}

// Añadimos el delegado de notificaciones e implementamos UNUserNotificationCenterDelegate
//  -> para mostrar las notificaciones mientras la app está en primer plano
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()
    private override init() { super.init() }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
