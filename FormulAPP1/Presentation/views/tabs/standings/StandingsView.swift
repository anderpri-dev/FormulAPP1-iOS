//
//  StandingsView.swift
//  FormulAPP1-test
//
//  Created by ANDER on 11/4/25.
//

import SwiftUI

struct StandingsView: View {
    
    @EnvironmentObject var driversVM: DriversViewModel
    @EnvironmentObject var constructorsVM: ConstructorsViewModel
    
    // Para controlar las pestañas
    @State private var selectedTab = 0
    @State private var isShowingDetail = false
    @State private var selectedDriver: DriverStandingDomainModel? = nil
    @State private var selectedConstructor: ConstructorStandingDomainModel? = nil
    
    // Calcular si necesitamos pantalla partida
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isSplitView: Bool {
        let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        // regular -> pantallas más grandes (iPad, Mac)
        let isRegular = horizontalSizeClass == .regular
        return isLandscape && isRegular
    }
    
    var body: some View {
        // Si el dispositivo es un iPad o Mac y está en apaisado
        // -> mostrar la vista dividida
        Group {
            if isSplitView {
                NavigationSplitView {
                    VStack {
                        Picker("nav.standings", selection: $selectedTab) {
                            Text("nav.drv").tag(0)
                            Text("nav.ctr").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        if selectedTab == 0 {
                            DriverStandingView(onSelect: { selectedDriver = $0 })
                                .environmentObject(driversVM)
                        } else {
                            ConstructorStandingView(onSelect: { selectedConstructor = $0 })
                                .environmentObject(constructorsVM)
                        }
                        
                        Spacer()
                    }
                } detail: {
                    if selectedTab == 0 {
                        if let driver = selectedDriver {
                            DriverStandingDetailView(driverStanding: driver)
                        }
                    } else {
                        if let constructor = selectedConstructor {
                            ConstructorStandingDetailView(standing: constructor)
                        }
                    }
                }
                .navigationSplitViewColumnWidth(min: 800, ideal: 800, max: 800)
            } else {
                NavigationStack {
                    
                    VStack {
                        
                        if !isShowingDetail {
                            Picker("nav.standings", selection: $selectedTab) {
                                Text("nav.drv").tag(0)
                                Text("nav.ctr").tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                        }
                        
                        if selectedTab == 0 {
                            DriverStandingView(onSelect: { selectedDriver = $0 })
                                .environmentObject(driversVM)
                            
                        } else {
                            ConstructorStandingView(onSelect: { selectedConstructor = $0 })
                                .environmentObject(constructorsVM)
                        }
                        
                        Spacer()
                    }
                    // Vista de detalle de piloto
                    .navigationDestination(item: $selectedDriver) { driver in
                        DriverStandingDetailView(driverStanding: driver)
                            .withLocalizedBackButton()
                    }
                    // Vista de detalle de constructor
                    .navigationDestination(item: $selectedConstructor) { constructor in
                        ConstructorStandingDetailView(standing: constructor)
                            .withLocalizedBackButton()
                    }
                    // Deslizar para cambiar de pestaña
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -50 && selectedTab < 1 {
                                    selectedTab += 1
                                }
                                if value.translation.width > 50 && selectedTab > 0 {
                                    selectedTab -= 1
                                }
                            }
                    )
                }
            }
        }
    }
}

#Preview {
    StandingsView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(ViewModelProvider.shared.driversVM)
        .environmentObject(ViewModelProvider.shared.constructorsVM)
}
