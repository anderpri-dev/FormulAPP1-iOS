//
//  ConstructorsViewModel.swift
//  FormulAPP1-test
//
//  Created by ANDER on 30/4/25.
//

import Foundation
import CoreData

class ConstructorsViewModel: ObservableObject {
    
    @Published var listaStandings: [ConstructorStandingDomainModel] = []
    
    private let standingsRepository: ConstructorStandingRepository
    
    init() {
        self.standingsRepository = ConstructorStandingRepository.shared
    }
    
    func fetchStandings() {
        APIService.shared.fetchConstructorStandings { resultado in
            switch resultado {
            case .success(let respuesta):
                DispatchQueue.main.async {
                    if case let .ConstructorStandings(datos) = respuesta.datos {
                        let standings = datos.tablaPosiciones.listaPosiciones[0].posicionesConstructores
                        self.syncStandingsToCoreDataAndReload(standings)
                    }
                }
            case .failure(let error):
                print("❌ Error al obtener standings: \(error)")
            }
        }
    }
    
    private func syncStandingsToCoreDataAndReload(_ apiStandings: [ConstructorStandingDomainModel]) {
        do {
            try standingsRepository.deleteAll()
            
            for standing in apiStandings {
                try standingsRepository.save(from: standing)
            }
            
            let sorted = try standingsRepository.fetchAll()
                .sorted { Int($0.posicion) ?? 0 < Int($1.posicion) ?? 0 }
            
            DispatchQueue.main.async {
                self.listaStandings = sorted
                print("✅ Constructor standings actualizados desde Core Data")
            }
            
        } catch {
            print("❌ Error sincronizando Constructor standings: \(error)")
        }
    }
    
    func getStandings() {
        do {
            let sorted = try standingsRepository.fetchAll()
                .sorted { Int($0.posicion) ?? 0 < Int($1.posicion) ?? 0 }
            
            DispatchQueue.main.async {
                self.listaStandings = sorted
                print("✅ Constructor standings actualizados desde Core Data")
            }
        } catch {
            print("❌ Error sincronizando Constructor standings: \(error)")
        }
    }
    
    func getConstructorStandingById(constructorId: String) -> ConstructorStandingDomainModel? {
        try? standingsRepository.fetchByConstructorId(constructorId)
    }
    
}
