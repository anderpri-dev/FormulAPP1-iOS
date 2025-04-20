//
//  DriverStandingCard.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import SwiftUI

struct DriverStandingCard: View {
    
    // Para recargar lo que tiene que ver con el idioma (fechas, sufijos...)
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"
    
    let standing: DriverStandingDomainModel
    
    var body: some View {
        let driver = standing.piloto
        let teamId = standing.constructores.last?.constructorId ?? ""
        
        GeometryReader { metrics in
            HStack(spacing: 0) {
                
                // Foto del piloto
                Group {
                    VStack {
                        Spacer()
                        Image(driver.driverId)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 4)
                            .mask {
                                LinearGradient(stops: [
                                    .init(color: .blue, location: 0.85),
                                    .init(color: .clear, location: 0.95)
                                ], startPoint: .top, endPoint: .bottom)
                            }
                        Spacer()
                    }
                }.frame(width: metrics.size.width * 0.3)
                
                // Datos del piloto
                VStack(alignment: .leading) {
                    // Nombre y número del piloto
                    HStack {
                        VStack(alignment: .leading) {
                            Text(driver.givenName)
                                .font(.title2)
                            Text(driver.familyName)
                                .font(.title)
                        }
                        Spacer()
                        HStack(alignment: .top) {
                            Text(standing.posicion)
                                .font(.title)
                                .fontDesign(.monospaced)
                                //.padding()
                            
                            Text(ordinalSuffix(position: Int(standing.posicion) ?? 0))
                        }.foregroundColor(
                            standing.posicion == "1" ? .yellow :
                            standing.posicion == "2" ? .gray :
                            standing.posicion == "3" ? .brown : .primary
                        )
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text(verbatim: "🎂 \(localizedDate(driver.dateOfBirth))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            (
                                Text(flag(driver.nationality))
                                +
                                Text(verbatim: " ")
                                +
                                Text(LocalizedStringKey( country(driver.nationality)) )
                            )
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(verbatim: "\(standing.puntos)")
                            .font(.title2)
                            .fontDesign(.monospaced)
                        Text("pt")
                        
                    }
                    
                        
                }.padding(.all)
            }
            .frame(height: 150)
            .background(
                LinearGradient(stops: [
                    .init(color: teamColor(team: teamId), location: 0.05),
                    .init(color: .clear, location: 0.35)
                ], startPoint: .leading, endPoint: .bottom)
            )
            Spacer()
        }
        .frame(height: 150)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
        //.shadow(color: Color.black.opacity(0.2), radius: 4)
    }
    
}
