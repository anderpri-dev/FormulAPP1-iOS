//
//  RacesViewModel.swift
//  FormulAPP1-test
//
//  Created by ANDER on 7/4/25.
//

import Foundation
import Combine

class RacesViewModel: ObservableObject {
    
    private var cancelables = Set<AnyCancellable>()
    @Published var listaCarreras: [RaceDomainModel] = []
    @Published var nextRace: RaceDomainModel?
    
    private let racesRepository: RaceRepository
    
    init() {
        self.racesRepository = RaceRepository.shared
    }
    
    func fetchRaces() {
        APIService.shared.fetchRaces { resultado in
            switch resultado {
            case .success(let respuesta):
                DispatchQueue.main.async {
                    if case let .Race(datos) = respuesta.datos {
                        
                        let races = datos.tablaCarreras.listaCarreras
                        //races.forEach { print($0.circuit.circuitId) }
                        //print(races)
                        //self.listaCarreras = races
                        self.syncRacesToCoreDataAndReload(races)
                        self.getNextRace()
                    }
                }
            case .failure(let error):
                print("❌ Error al obtener carreras: \(error)")
            }
        }
    }
    
    private func syncRacesToCoreDataAndReload(_ apiRaces: [RaceDomainModel]) {
        do {
            try racesRepository.deleteAll()
            
            for race in apiRaces {
                try racesRepository.save(from: race)
            }
            
            let sorted = try racesRepository.fetchAll()
                .sorted { Int($0.round) ?? 0 < Int($1.round) ?? 0 }
            
            DispatchQueue.main.async {
                self.listaCarreras = sorted
                print("✅ Carreras actualizadas desde Core Data")
            }
            
        } catch {
            print("❌ Error sincronizando carreras: \(error)")
        }
    }
    
    func getRaces() {
        do {
            let sorted = try racesRepository.fetchAll()
                .sorted { Int($0.round) ?? 0 < Int($1.round) ?? 0 }
            
            DispatchQueue.main.async {
                self.listaCarreras = sorted
                print("✅ Carreras actualizadas desde Core Data")
            }
        } catch {
            print("❌ Error sincronizando carreras: \(error)")
        }
    }
    
    func getNextRace() {
        do {
            let allRaces = try racesRepository.fetchAll()
            let now = Date()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            formatter.locale = Locale(identifier: "en_US_POSIX")

            // Filtrar las carreras futuras y ordenarlas por fecha
            // Se guardan en una tupla (carrera, fecha) para poder ordenarlas
            let futureRaces = allRaces.compactMap { race -> (RaceDomainModel, Date)? in
                if let sessionDate = formatDateFromSessionDateTime(date: race.raceSession.date, time: race.raceSession.time), sessionDate > now {
                    return (race, sessionDate)
                }
                return nil
            }
            .sorted { $0.1 < $1.1 } // ordenar por fecha

            DispatchQueue.main.async {
                self.nextRace = futureRaces.first?.0
                if let next = self.nextRace {
                    print("✅ Next race: \(next.raceName)")
                } else {
                    print("ℹ️ No upcoming races found")
                }
            }
        } catch {
            print("❌ Error fetching next race: \(error)")
        }
    }
}
