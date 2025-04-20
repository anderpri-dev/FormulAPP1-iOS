//
//  DriversView.swift
//  FormulAPP1-test
//
//  Created by ANDER on 7/4/25.
//

import SwiftUI
import CoreData

struct DriverStandingView: View {

    @EnvironmentObject var driversVM: DriversViewModel
    
    var onSelect: (DriverStandingDomainModel) -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(driversVM.listaStandings, id: \.posicion) { standingElem in
                        
                        Button {
                            onSelect(standingElem)
                        } label: {
                            DriverStandingCard(standing: standingElem)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                //.scrollTargetLayout()
            }
            /*
            .refreshable {
                // Cuando refresque, llamamos a la API y se actualizan los datos también en CoreData
                driversVM.fetchStandings()
            }
            */
        }
        .onAppear {
            // Cuando aparezca, NO llamamos a la API, solo lo que ya está en CoreData
            driversVM.getStandings()
        }
    }
}

#Preview {
    DriverStandingView(onSelect: { _ in })
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(ViewModelProvider.shared.driversVM)
}
