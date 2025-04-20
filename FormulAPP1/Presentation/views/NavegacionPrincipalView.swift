//
//  NavegacionPrincipalView.swift
//  FormulAPP1-test
//
//  Created by ANDER on 7/4/25.
//

import SwiftUI

struct NavegacionPrincipalView: View {
    
    //@Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var driversVM: DriversViewModel
    @EnvironmentObject var constructorsVM: ConstructorsViewModel
    @EnvironmentObject var racesVM: RacesViewModel
    
    var body: some View {
        TabView {
            MainView().tabItem {
                Image(systemName: "house")
                Text("nav.home")
            }
            //.environment(\.managedObjectContext, viewContext)
            .environmentObject(racesVM)
            
            StandingsView().tabItem {
                Image(systemName: "chart.bar.xaxis")
                Text("nav.standings")
            }
            //.environment(\.managedObjectContext, viewContext)
            .environmentObject(driversVM)
            .environmentObject(constructorsVM)
            
            CircuitsView().tabItem {
                Image(systemName: "point.forward.to.point.capsulepath")
                Text("nav.circuits")
            }
            //.environment(\.managedObjectContext, viewContext)
            .environmentObject(racesVM)
            
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("nav.settings")
            }
        }
    }
}

#Preview {
    NavegacionPrincipalView()//.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(ViewModelProvider.shared.racesVM)
        .environmentObject(ViewModelProvider.shared.constructorsVM)
        .environmentObject(ViewModelProvider.shared.driversVM)
}
