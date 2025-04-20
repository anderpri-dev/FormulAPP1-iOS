//
//  ConstructorCardWidgetView.swift
//  FormulAPP1
//
//  Created by ANDER on 5/5/25.
//

import SwiftUI

struct ConstructorCardWidgetView: View {
    
    let standing: ConstructorStandingDomainModel
    @Environment(\.widgetFamily) var family

    var frameWidth: CGFloat {
        switch family {
        case .systemMedium: return 110
        default: return 60
        }
    }
    
    var body: some View {
        let constructor = standing.constructor
        
        Group {
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
                .frame(width: frameWidth)
                
                // Datos del equipo
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(constructor.nombre)
                                .font(.title)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
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
                        }
                        .foregroundColor(
                            standing.posicion == "1" ? .yellow :
                            standing.posicion == "2" ? .gray :
                            standing.posicion == "3" ? .brown : .primary
                        )
                        Spacer()
                        Text(standing.puntos)
                            .font(.title2)
                            .fontDesign(.monospaced)
                        Text(LocalizedStringManager.shared.localizedString("pt"))
                    }
                    
                }.padding(.horizontal, 16).padding(.vertical, 24)
            }
        }.containerBackground(for: .widget) {
            LinearGradient(stops: [
                .init(color: teamColor(team: constructor.constructorId), location: 0.05),
                .init(color: .clear, location: 0.35)
            ], startPoint: .leading, endPoint: .bottom)
        }
    }
}


