//
//  CircuitCard.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//
import SwiftUI

struct CircuitCard: View {
    
    // Para recargar lo que tiene que ver con el idioma (fechas, sufijos...)
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"
    
    let race: RaceDomainModel
    
    var body: some View {
        HStack(spacing: 0) {
            // Logo del equipo
            Group {
                VStack {
                    HStack {
                        Text(LocalizedStringKey("race.round \(race.round)"))
                            .font(.subheadline)
                        Text(verbatim: "−")
                        Text(formatDateRange(startDate: race.firstPractice!.date, endDate: race.raceSession.date))
                            .font(.subheadline)
                    }.foregroundColor(.gray)
                    Text(race.raceName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Image("\(race.circuit.circuitId)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 4)
                }.padding(.all)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}


// Para dar formato a las rondas:
// 15-17 ABR --- APR 15-17
// 30 APR - 2 MAY
func formatDateRange(startDate: String, endDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    let languageCode = UserPreferencesManager.shared.getLanguage()
    let locale: Locale = getLocaleFromLanguageCode(languageCode)
    
    let outputFormatterSameMonth = DateFormatter()
    outputFormatterSameMonth.dateFormat = "dd"
    outputFormatterSameMonth.locale = locale
    
    let outputFormatterDifferentMonth = DateFormatter()
    if languageCode == "en" || languageCode == "eu" {
        outputFormatterDifferentMonth.dateFormat = "MMM dd"
    } else {
        outputFormatterDifferentMonth.dateFormat = "dd MMM"
    }
    outputFormatterDifferentMonth.locale = locale
    
    guard let start = inputFormatter.date(from: startDate),
          let end = inputFormatter.date(from: endDate) else {
        return "\(startDate) - \(endDate)"
    }
    
    let startMonth = Calendar.current.component(.month, from: start)
    let endMonth = Calendar.current.component(.month, from: end)
    
    if startMonth == endMonth {
        if languageCode == "en" || languageCode == "eu" {
            return "\(outputFormatterDifferentMonth.string(from: start).uppercased())-\(outputFormatterSameMonth.string(from: end))"
        } else {
            return "\(outputFormatterSameMonth.string(from: start))-\(outputFormatterDifferentMonth.string(from: end).uppercased())"
        }
    } else {
        return "\(outputFormatterDifferentMonth.string(from: start).uppercased()) - \(outputFormatterDifferentMonth.string(from: end).uppercased())"
    }
}
