//
//  CircuitsView.swift
//  FormulAPP1
//
//  Created by ANDER on 30/4/25.
//

import SwiftUI

struct CircuitsView: View {
    
    @EnvironmentObject var racesVM: RacesViewModel
    
    // Calcular si necesitamos pantalla partida
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isSplitView: Bool {
        let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        // regular -> pantallas más grandes (iPad, Mac)
        let isRegular = horizontalSizeClass == .regular
        return isLandscape && isRegular
    }
    
    @State private var selectedRace: RaceDomainModel?
    var body: some View {
        Group {
            if isSplitView {
                NavigationSplitView {
                    List(racesVM.listaCarreras, id: \.round, selection: $selectedRace) { race in
                        CircuitCard(race: race)
                            .tag(race)
                            .onTapGesture {
                                if selectedRace == race {
                                    selectedRace = nil
                                } else {
                                    selectedRace = race
                                }
                            }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        racesVM.getRaces()
                    }
                } detail: {
                    if let race = selectedRace {
                        RaceDetailView(race: race)
                    }
                }
            } else {
                NavigationStack {
                    ScrollView(.vertical) {
                        LazyVStack {
                            ForEach(racesVM.listaCarreras, id: \.round) { race in
                                NavigationLink(destination: RaceDetailView(race: race).withLocalizedBackButton()) {
                                    CircuitCard(race: race)
                                }.buttonStyle(.plain)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                        .scrollTargetLayout()
                    }
                    //.refreshable {
                    // Cuando refresque, llamamos a la API y se actualizan los datos también en CoreData
                    //racesVM.fetchRaces()
                    //}
                    .onAppear {
                        // Cuando aparezca, NO llamamos a la API, solo lo que ya está en CoreData
                        racesVM.getRaces()
                    }
                }
            }
        }
    }
    
    
}

#Preview {
    CircuitCard(race: sampleRace)
}

#Preview {
    CircuitsView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(ViewModelProvider.shared.racesVM)
    
}
