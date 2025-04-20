//
//  ConstructorStandingDetailView.swift
//  FormulAPP1
//
//  Created by ANDER on 6/5/25.
//

import SwiftUI

struct ConstructorStandingDetailView: View {
    let standing: ConstructorStandingDomainModel
    @State private var isFavourite = false
    let userPreferencesManager = UserPreferencesManager.shared
    
    // Para recargar lo que tiene que ver con el idioma (fechas, sufijos...)
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"

    var body: some View {
        let constructor = standing.constructor
        
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .center) {
                // Foto coche y logo del equipo y posición
                Group {
                    VStack {
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
                    }
                }
                .frame(width: 200, height: 200)
                
                VStack(spacing: 4) {
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
                    .shadow(radius: 4)
                    
                    HStack {
                        Text(standing.puntos)
                            .font(.title2)
                            .fontDesign(.monospaced)
                        Text("pt")
                    }
                    .shadow(radius: 4)
                }
                .padding(16)
                .background(.black.opacity(0.2))
                .cornerRadius(16)
            }

            // Nombre del equipo
            Text(constructor.nombre.uppercased())
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Nacionalidad
            HStack {
                Text(flag(constructor.nacionalidad))
                Text(LocalizedStringKey( country(constructor.nacionalidad)))
            }
            .font(.subheadline)

            // Botón añadir/quitar favorito
            Button(action: {
                if isFavourite {
                    userPreferencesManager.removeFavouriteConstructor()
                } else {
                    userPreferencesManager.setFavouriteConstructor(constructorId: constructor.constructorId)
                }
                isFavourite.toggle()
            }) {
                Text(isFavourite ? "ctr.remove_fav" : "ctr.add_fav")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFavourite ? Color.red.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundColor(isFavourite ? .red : .blue)
                    .cornerRadius(8)
            }
            .padding(.top, 16)

            Spacer()
        }
        .padding()
        .cornerRadius(12)
        .background(
            LinearGradient(stops: [
                .init(color: teamColor(team: constructor.constructorId), location: 0.05),
                .init(color: .clear, location: 0.35)
            ], startPoint: .top, endPoint: .bottom)
        )
        .onAppear {
            let fav = userPreferencesManager.getFavouriteConstructor()
            isFavourite = (fav == constructor.constructorId)
        }
        .id(selectedLanguage)
    }
}

#Preview {
    ConstructorStandingDetailView(standing: sampleStandingConstructor)
}
