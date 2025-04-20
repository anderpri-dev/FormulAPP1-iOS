//
//  ViewsUtils.swift
//  FormulAPP1-test
//
//  Created by ANDER on 11/4/25.
//

import Foundation
import SwiftUICore
import SwiftUI

// Diccionario con la bandera y clave Localizable de cada país
let nationalityInfo: [String: (flag: String, key: String)] = [
    "Thai": ("🇹🇭", "nat.thai"),
    "Spanish": ("🇪🇸", "nat.spanish"),
    "Italian": ("🇮🇹", "nat.italian"),
    "British": ("🇬🇧", "nat.british"),
    "Brazilian": ("🇧🇷", "nat.brazilian"),
    "Australian": ("🇦🇺", "nat.australian"),
    "French": ("🇫🇷", "nat.french"),
    "German": ("🇩🇪", "nat.german"),
    "New Zealander": ("🇳🇿", "nat.new_zealander"),
    "Monegasque": ("🇲🇨", "nat.monegasque"),
    "Canadian": ("🇨🇦", "nat.canadian"),
    "Japanese": ("🇯🇵", "nat.japanese"),
    "Dutch": ("🇳🇱", "nat.dutch"),
    "Swiss": ("🇨🇭", "nat.swiss"),
    "Austrian": ("🇦🇹", "nat.austrian"),
    "American": ("🇺🇸", "nat.american")
]

func flag(_ nationality: String) -> String {
    return nationalityInfo[nationality]?.flag ?? "🇺🇳"
}

func country(_ nationality: String) -> String {
    return nationalityInfo[nationality]?.key ?? nationality
}

// Para obtener el sufijo ordinal según el idioma
func ordinalSuffix(position: Int) -> String {
    
    let languageFromPrefs = UserPreferencesManager.shared.getLanguage()
    let languageCode = (languageFromPrefs == "system" ? nil : languageFromPrefs) ?? (Locale.current.language.languageCode?.identifier ?? "en")
    
    switch languageCode {
    case "en":
        let suffixes = ["th", "st", "nd", "rd"]
        let mod100 = position % 100 // últimos 2 dígitos
        let mod10 = position % 10 // último dígito

        if mod100 >= 11 && mod100 <= 13 {
            // "th" para 11, 12, 13
            return suffixes[0]
        }
        if mod10 >= 1 && mod10 <= 3 {
            // "st", "nd", "rd" para los acabados en 1, 2, 3
            // exceptuando 11, 12, 13 (caso anterior)
            return suffixes[mod10]
        }
        return suffixes[0] // "th" para el resto
    case "es":
        return "º"
    case "eu":
        return "."
    default:
        return "" // Por defecto, sin sufijo
    }
}

// Diccionario con el color hexadecimal de cada equipo
let teamColors: [String: String] = [
    "red_bull": "3671C6",
    "red_bull_sample": "3671C6",
    "mclaren": "FF8000",
    "sauber": "52E252",
    "rb": "6692FF",
    "alpine": "0093CC",
    "mercedes": "27F4D2",
    "aston_martin": "229971",
    "ferrari": "E80020",
    "williams": "64C4FF",
    "haas": "B6BABD"
]

// Para obtener el color del equipo a partir de su nombre
func teamColor(team: String?) -> Color {
    let hex = teamColors[team ?? ""] ?? "FF0000" // de default .red
    return Color(hex: hex)
}

// Para convertir un color hexadecimal a Color
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

// Para convertir la fecha y hora de la sesión a un objeto Date
func formatDateFromSessionDateTime(date: String, time: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    let combined = "\(date)T\(time)"
    return formatter.date(from: combined)
}



func localizedDate(_ isoDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    let languageCode = UserPreferencesManager.shared.getLanguage()
    let locale: Locale = getLocaleFromLanguageCode(languageCode)
    
    let outputFormatter = DateFormatter()
    if languageCode == "eu" {
        outputFormatter.dateFormat = "YYYY MMM d"
    } else {
        outputFormatter.dateStyle = .medium
    }
    outputFormatter.locale = locale
    
    if let date = inputFormatter.date(from: isoDate) {
        return outputFormatter.string(from: date)
    } else {
        return isoDate
    }
}

// Para obtener el Locale a partir del código de idioma
// Se usa en el AppDelegate y también en este ViewsUtils
func getLocaleFromLanguageCode(_ languageCode: String?) -> Locale {
    switch languageCode {
    case "en":
        return Locale(identifier: "en")
    case "es":
        return Locale(identifier: "es")
    case "eu":
        return Locale(identifier: "eu")
    default:
        return Locale.current
    }
}
