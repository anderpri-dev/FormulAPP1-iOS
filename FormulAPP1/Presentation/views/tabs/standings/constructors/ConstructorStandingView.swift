//
//  ConstructorStandingView.swift
//  FormulAPP1
//
//  Created by ANDER on 30/4/25.
//

import SwiftUI

struct ConstructorStandingView: View {
    
    @EnvironmentObject var constructorsVM: ConstructorsViewModel
    
    var onSelect: (ConstructorStandingDomainModel) -> Void

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(constructorsVM.listaStandings, id: \.posicion) { standingElem in
                        Button {
                            onSelect(standingElem)
                        } label: {
                            ConstructorStandingCard(standing: standingElem, fromMainView: false)
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
                constructorsVM.fetchStandings()
            }
            */
        }
        .onAppear {
            // Cuando aparezca, NO llamamos a la API, solo lo que ya está en CoreData
            constructorsVM.getStandings()
        }
    }
}


#Preview {
    ConstructorStandingView(onSelect: { _ in })
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(ViewModelProvider.shared.constructorsVM)
}

