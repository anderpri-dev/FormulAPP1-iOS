//
//  FormulAPP1App.swift
//  FormulAPP1
//
//  Created by ANDER on 20/4/25.
//

import SwiftUI

@main
struct FormulAPP1App: App {
    let persistenceController = PersistenceController.shared
    let provider = ViewModelProvider.shared
    
    // Permiso de notificaciones
    init() {
        NotificationHelper.requestPermission()
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }
    
    // Cargamos la configuración de color
    @AppStorage("selectedColorScheme", store: UserPreferencesManager.sharedDefaults) private var selectedColorScheme: String = "system"
    var colorScheme: ColorScheme? {
        switch selectedColorScheme {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }
    
    // Cargamos la configuración de idioma desde ViewsUtils
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"
    var locale: Locale {
        getLocaleFromLanguageCode(selectedLanguage)
    }
    
    private let scheduler = DailyScheduler()

    var body: some Scene {
        WindowGroup {
            // Cargamos la navegación principal con los objetos de entorno necesarios
            NavegacionPrincipalView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(provider.driversVM)
                .environmentObject(provider.constructorsVM)
                .environmentObject(provider.racesVM)
                .preferredColorScheme(colorScheme)
                .environment(\.locale, locale)
        }
    }
}
