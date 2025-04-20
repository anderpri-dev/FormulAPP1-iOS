//
//  ConstructorStandingCard.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import SwiftUI

struct ConstructorStandingCard: View {
    
    // Para recargar lo que tiene que ver con el idioma (fechas, sufijos...)
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"
    
    let standing: ConstructorStandingDomainModel
    let fromMainView: Bool
    
    var body: some View {
        let constructor = standing.constructor
        let width = fromMainView ? 0.3 : 0.4
        
        GeometryReader { metrics in
            HStack(spacing: 0) {
                // Logo del equipo
                Group {
                    VStack {
                        Spacer()
                        Image("\(constructor.constructorId)-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 4)
                            .padding(.horizontal, 8)
                        Image("\(constructor.constructorId)-car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 4)
                            .padding(.horizontal, 4)
                        Spacer()
                    }
                }
                .frame(width: metrics.size.width * width)
                
                // Datos del equipo
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(constructor.nombre)
                                .font(.title)
                        }
                        Spacer()
                        HStack(alignment: .top) {
                            Text(standing.posicion)
                                .font(.title)
                                .fontDesign(.monospaced)
                            Text(ordinalSuffix(position: Int(standing.posicion) ?? 0))
                        }
                        .foregroundColor(
                            standing.posicion == "1" ? .yellow :
                            standing.posicion == "2" ? .gray :
                            standing.posicion == "3" ? .brown : .primary
                        )
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            (
                                Text(flag(constructor.nacionalidad))
                                +
                                Text(verbatim: " ")
                                +
                                Text(LocalizedStringKey( country(constructor.nacionalidad)) )
                            )
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(standing.puntos)
                            .font(.title2)
                            .fontDesign(.monospaced)
                        Text("pt")
                    }
                    
                }.padding(.horizontal, 16).padding(.vertical, 24)
            }
            .frame(height: 150)
            .background(
                LinearGradient(stops: [
                    .init(color: teamColor(team: constructor.constructorId), location: 0.05),
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
