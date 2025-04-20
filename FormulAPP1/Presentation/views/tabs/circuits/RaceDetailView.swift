//
//  RaceDetailView.swift
//  FormulAPP1
//
//  Created by ANDER on 5/5/25.
//


import SwiftUI
import MapKit

struct RaceDetailView: View {
    let race: RaceDomainModel
    
    @State private var region: MKCoordinateRegion
    let circuitLat: Double
    let circuitLong: Double
    
    // Para recargar lo que tiene que ver con el idioma (fechas, sufijos...)
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"
    
    init(race: RaceDomainModel) {
        // Cargamos la región del mapa
        self.race = race
        circuitLat = Double(race.circuit.location.lat) ?? 0
        circuitLong = Double(race.circuit.location.long) ?? 0
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: circuitLat, longitude: circuitLong),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        ))
    }
    
    func formatSessionDate(_ session: SessionModel?) -> String {
        guard let session = session else { return "" }
        let dateString = "\(session.date)T\(session.time)"
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let languageCode = selectedLanguage
        let locale: Locale = getLocaleFromLanguageCode(languageCode)
        
        let outputFormatter = DateFormatter()
        if languageCode == "eu" {
            outputFormatter.dateFormat = "yyyy MMM dd — HH:mm"
        } else if languageCode == "en" {
            outputFormatter.dateFormat = "MMM dd, yyyy — HH:mm"
        } else {
            outputFormatter.dateFormat = "dd MMM yyyy — HH:mm"
        }
        outputFormatter.locale = locale
        
        //let dateString = "\(date)T\(time)"
        if let sessionDate = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: sessionDate).uppercased()
        } else {
            return "\(session.date) \(session.time)"
        }
    }

    var body: some View {
        //var languageCode = selectedLanguage
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(LocalizedStringKey("race.round \(race.round)"))
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Image(race.circuit.circuitId)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .shadow(radius: 4)
                
                VStack{
                    Text(race.raceName)
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(race.circuit.circuitName)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                
                VStack(spacing: 12) {
                    
                    VStack {
                        Text("race.sessions")
                            .textCase(.uppercase)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        
                    HStack {
                        Text("race.p1")
                        Spacer()
                        Text(formatSessionDate(race.firstPractice))
                            .foregroundColor(.gray)
                    }
                    if let secondPractice = race.secondPractice {
                        HStack {
                            Text("race.p2")
                            Spacer()
                            Text(formatSessionDate(secondPractice))
                                .foregroundColor(.gray)
                        }
                    }
                    if let thirdPractice = race.thirdPractice {
                        HStack {
                            Text("race.p3")
                            Spacer()
                            Text(formatSessionDate(thirdPractice))
                                .foregroundColor(.gray)
                        }
                    }
                    if let sprintQualifying = race.sprintQualifying {
                        HStack {
                            Text("race.spquali")
                            Spacer()
                            Text(formatSessionDate(sprintQualifying))
                                .foregroundColor(.gray)
                        }
                    }
                    if let sprint = race.sprint {
                        HStack {
                            Text("race.sprace")
                            Spacer()
                            Text(formatSessionDate(sprint))
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Text("race.quali")
                        Spacer()
                        Text(formatSessionDate(race.qualifying))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("race.race")
                            .textCase(.uppercase)
                            .bold()
                            .font(.title3)
                        Spacer()
                        Text(formatSessionDate(race.raceSession))
                            .foregroundColor(.gray)
                            .bold()
                            .font(.title3)
                    }.padding(.vertical, 8)
                }
                .font(.body)
                .padding(.top, 16)
               
                VStack {
                    Text("race.map")
                        .textCase(.uppercase)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }.frame(maxWidth: .infinity, alignment: .leading)
                // Añadimos mapa y pin del circuito
                // Deprecated en SDK 17.0 pero el target es 16.0 así que mantenemos así con warnings
                Group() {
                    Map(coordinateRegion: $region, annotationItems: [CircuitMapPin(coordinate: CLLocationCoordinate2D(latitude: circuitLat, longitude: circuitLong))]) { item in
                        MapAnnotation(coordinate: item.coordinate) {
                            Image(systemName: "flag.pattern.checkered.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                }
                .frame(height: 250)
                .cornerRadius(12)
                .shadow(radius: 4)
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("race.details"))
        .navigationBarTitleDisplayMode(.inline)
        .id(selectedLanguage)
    }
}

struct CircuitMapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    RaceDetailView(race: sampleRace)
}
