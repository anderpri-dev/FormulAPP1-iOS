//
//  DriverStandingDetailView.swift
//  FormulAPP1
//
//  Created by ANDER on 6/5/25.
//

import SwiftUI

struct DriverStandingDetailView: View {
    let driverStanding: DriverStandingDomainModel
    @State private var isFavourite = false
    let userPreferencesManager = UserPreferencesManager.shared
    
    // Para recargar lo que tiene que ver con el idioma (fechas, sufijos...)
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"

    var body: some View {
        let driver = driverStanding.piloto
        let teamId = driverStanding.constructores.last?.constructorId ?? ""
        
        VStack(alignment: .leading, spacing: 16) {
            // Foto | Código de piloto y dorsal
            HStack(alignment: .center) {
                
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
                    .frame(width: 200, height: 200)
                
                
                VStack(spacing: 4){
                    
                    HStack() {
                        Text(driver.code)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(verbatim: "#\(driver.permanentNumber)")
                            .font(.headline)
                            .fontDesign(.monospaced)
                    }.foregroundColor(.white)
                        .shadow(radius: 4)
                    HStack(alignment: .top) {
                        Text(driverStanding.posicion)
                            .font(.title)
                            .fontDesign(.monospaced)
                            //.padding()
                        Text(ordinalSuffix(position: Int(driverStanding.posicion) ?? 0))
                    }.foregroundColor(
                        driverStanding.posicion == "1" ? .yellow :
                            driverStanding.posicion == "2" ? .gray :
                            driverStanding.posicion == "3" ? .brown : .primary
                    ).shadow(radius: 4)
                    HStack {
                        Text(driverStanding.puntos)
                            .font(.title2)
                            .fontDesign(.monospaced)
                        Text("pt")
                    }.shadow(radius: 4)
                    
                }
                .padding(16)
                .background(.black.opacity(0.2))
                .cornerRadius(16)
                //Spacer()
            }
            
            // Nombre y apellido
            Text(verbatim: "\(driver.givenName) \(driver.familyName.uppercased())")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // Logo del equipo
            HStack {
                if let team = driverStanding.constructores.last {
                    Image("\(team.constructorId)-badge")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 4)
                    Text(team.nombre.uppercased())
                        .font(.headline)
                }
            }
            
            // Nacionalidad y fecha de nacimiento
            HStack {
                Text(flag(driver.nationality))
                Text(LocalizedStringKey( country(driver.nationality)))
            }
            .font(.subheadline)
            
            HStack {
                Text(verbatim: "🎂")
                Text(localizedDate(driver.dateOfBirth))
            }
            .font(.subheadline)
            
            // Botón añadir/quitar favorito
            Button(action: {
                if isFavourite {
                    userPreferencesManager.removeFavouriteDriver()
                } else {
                    userPreferencesManager.setFavouriteDriver(driverId: driver.driverId)
                }
                isFavourite.toggle()
            }) {
                Text(isFavourite ? "drv.remove_fav" : "drv.add_fav")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFavourite ? Color.red.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundColor(isFavourite ? .red : .blue)
                    .cornerRadius(8)
            }
            .padding(.top, 16)
        }
        .padding()
        .cornerRadius(12)
        .background(
            LinearGradient(stops: [
                .init(color: teamColor(team: teamId), location: 0.05),
                .init(color: .clear, location: 0.35)
            ], startPoint: .top, endPoint: .bottom)
        )
        .onAppear {
            let fav = userPreferencesManager.getFavouriteDriver()
            isFavourite = (fav == driver.driverId)
        }
        .id(selectedLanguage)
        Spacer()
    }
}

#Preview {
    DriverStandingDetailView(driverStanding: sampleStandingDriver)
}
