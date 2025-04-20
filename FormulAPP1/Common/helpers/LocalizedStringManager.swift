//
//  LocalizedStringManager.swift
//  FormulAPP1
//
//  Created by ANDER on 20/5/25.
//

import Foundation


class LocalizedStringManager {
    static let shared = LocalizedStringManager()
    private init() {}
    
    // Obligatorio usar NSLocalizedString porque no estamos usando SwiftUI
    // Por lo tanto -> Hay que construir una función auxiliar para que sincronice el idioma de la notificación
    func localizedString(_ key: String, languageCode: String) -> String {
        guard
            let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    // Este se va a usar con los widgets, ya que el idioma no se sincroniza con la de la app y sí con el sistema
    func localizedString(_ key: String) -> String {
        // Obtener el lenguaje seleccionado del usuario
        let selectedLanguage = UserPreferencesManager.shared.getLanguage() ?? "system"
        let languageCode = selectedLanguage == "system" ? Locale.current.language.languageCode?.identifier ?? "en" : selectedLanguage
        return localizedString(key, languageCode: languageCode)
    }
}
