//
//  DriversViewModel.swift
//  FormulAPP1-test
//
//  Created by ANDER on 7/4/25.
//
import Foundation
import CoreData

class DriversViewModel: ObservableObject {
    
    @Published var listaStandings: [DriverStandingDomainModel] = []
    
    private let standingsRepository: DriverStandingRepository
    
    init() {
        self.standingsRepository = DriverStandingRepository.shared
    }
    
    func fetchStandings() {
        APIService.shared.fetchDriverStandings { resultado in
            switch resultado {
            case .success(let respuesta):
                DispatchQueue.main.async {
                    if case let .DriverStandings(datos) = respuesta.datos {
                        let standings = datos.tablaPosiciones.listaPosiciones[0].posicionesPilotos
                        self.syncStandingsToCoreDataAndReload(standings)
                    }
                }
            case .failure(let error):
                print("❌ Error al obtener driver Driver standings: \(error)")
            }
        }
    }
    
    private func syncStandingsToCoreDataAndReload(_ apiStandings: [DriverStandingDomainModel]) {
        do {
            try standingsRepository.deleteAll()
            
            for standing in apiStandings {
                try standingsRepository.save(from: standing)
            }
            
            let sorted = try standingsRepository.fetchAll()
                .sorted { Int($0.posicion) ?? 0 < Int($1.posicion) ?? 0 }
            
            DispatchQueue.main.async {
                self.listaStandings = sorted
                print("✅ Driver standings sincronizados desde Core Data")
            }
            
        } catch {
            print("❌ Error sincronizando Driver standings: \(error)")
        }
    }
    
    func getStandings() {
        do {
            let sorted = try standingsRepository.fetchAll()
                .sorted { Int($0.posicion) ?? 0 < Int($1.posicion) ?? 0 }
            
            DispatchQueue.main.async {
                self.listaStandings = sorted
                print("✅ Driver standings obtenidos desde Core Data")
            }
        } catch {
            print("❌ Error sincronizando Driver standings: \(error)")
        }
    }
    
    func getDriverStandingById(driverId: String) -> DriverStandingDomainModel? {
        try? standingsRepository.fetchByDriverId(driverId)
    }
    
}
