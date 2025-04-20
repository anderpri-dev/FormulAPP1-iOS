//
//  DriverCardWidgetView.swift
//  FormulAPP1
//
//  Created by ANDER on 5/5/25.
//

import SwiftUI

struct DriverCardWidgetView: View {
    let standing: DriverStandingDomainModel
    @Environment(\.widgetFamily) var family

    var frameWidth: CGFloat {
        switch family {
        case .systemSmall: return 60
        case .systemMedium: return 90
        default: return 60
        }
    }

    var body: some View {
        let driver = standing.piloto
        let teamId = standing.constructores.last?.constructorId ?? ""
        Group {
            HStack(spacing: 0) {
                
                // Foto del piloto
                Group {
                    VStack {
                        Spacer()
                        Image(driver.driverId)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 4)
                        Spacer()
                    }
                }.frame(width: frameWidth)
                
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
                        
                    }
                    
                    Spacer()
                    
                    // Posición y puntos
                    HStack {
                        HStack(alignment: .top) {
                            Text(standing.posicion)
                                .font(.title)
                                .fontDesign(.monospaced)
                            Text(ordinalSuffix(position: Int(standing.posicion) ?? 0))
                        }.foregroundColor(
                            standing.posicion == "1" ? .yellow :
                            standing.posicion == "2" ? .gray :
                            standing.posicion == "3" ? .brown : .primary
                        )
                        Spacer()
                        Text(verbatim: "\(standing.puntos)")
                            .font(.title2)
                            .fontDesign(.monospaced)
                        Text(LocalizedStringManager.shared.localizedString("pt"))
                    }
                }.padding(.all)
            }
        }.containerBackground(for: .widget) {
            //Color.clear
            LinearGradient(stops: [
                .init(color: teamColor(team: teamId), location: 0.05),
                .init(color: .clear, location: 0.35)
            ], startPoint: .leading, endPoint: .bottom)
        }
        
    }
    
}
