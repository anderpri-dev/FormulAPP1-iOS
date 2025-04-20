//
//  RaceRepository.swift
//  FormulAPP1
//
//  Created by ANDER on 30/4/25.
//

import Foundation
import CoreData

final class RaceRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    static let shared = RaceRepository()

    func save(from domainModel: RaceDomainModel) throws {
        let race = Race(context: context)
        race.season = domainModel.season
        race.round = domainModel.round
        race.raceName = domainModel.raceName
        race.url = domainModel.url
        
        // Circuito y ubicación
        let circuitModel = domainModel.circuit
        let locationModel = circuitModel.location
        
        let circuit = try context.fetchOrCreate(entity: Circuit.self,
                                                predicate: NSPredicate(format: "circuitId == %@", circuitModel.circuitId)) {
            $0.circuitId = circuitModel.circuitId
            $0.circuitName = circuitModel.circuitName
            $0.url = circuitModel.url
        }
        
        circuit.location = try context.fetchOrCreate(entity: Location.self,
                                                     predicate: NSPredicate(format: "lat == %@ AND long == %@", locationModel.lat, locationModel.long)) {
            $0.lat = locationModel.lat
            $0.long = locationModel.long
            $0.locality = locationModel.locality
            $0.country = locationModel.country
        }
        
        race.circuit = circuit
        
        // Crear sesiones opcionales
        func createSession(from model: SessionModel?) -> Session? {
            guard let model = model else { return nil }
            let session = Session(context: context)
            session.date = model.date
            session.time = model.time
            return session
        }
        
        race.raceSession = createSession(from: domainModel.raceSession)
        race.firstPractice = createSession(from: domainModel.firstPractice)
        race.secondPractice = createSession(from: domainModel.secondPractice)
        race.thirdPractice = createSession(from: domainModel.thirdPractice)
        race.qualifying = createSession(from: domainModel.qualifying)
        race.sprint = createSession(from: domainModel.sprint)
        race.sprintQualifying = createSession(from: domainModel.sprintQualifying)
        
        try context.save()
    }
    
    func fetchAll() throws -> [RaceDomainModel] {
        let fetchRequest: NSFetchRequest<Race> = Race.fetchRequest()
        let results = try context.fetch(fetchRequest)
        return results.compactMap { $0.toDomainModel() }
    }
    
    func deleteAll() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Race.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
        try context.save()
    }

}


extension Race {
    func toDomainModel() -> RaceDomainModel? {
        guard let circuit = self.circuit,
              let circuitId = circuit.circuitId,
              let circuitName = circuit.circuitName,
              let location = circuit.location,
              let raceSession = self.raceSession else {
            return nil
        }

        return RaceDomainModel(
            season: self.season ?? "",
            round: self.round ?? "",
            url: self.url,
            raceName: self.raceName ?? "",
            circuit: CircuitDomainModel(
                circuitId: circuitId,
                url: circuit.url,
                circuitName: circuitName,
                location: LocationDomainModel(
                    lat: location.lat ?? "",
                    long: location.long ?? "",
                    locality: location.locality ?? "",
                    country: location.country ?? ""
                )
            ),
            raceSession: SessionModel(date: raceSession.date ?? "", time: raceSession.time ?? ""),
            firstPractice: self.firstPractice.map { $0.toDomainModel() },
            secondPractice: self.secondPractice.map { $0.toDomainModel() },
            thirdPractice: self.thirdPractice.map { $0.toDomainModel() },
            qualifying: self.qualifying.map { $0.toDomainModel() },
            sprint: self.sprint.map { $0.toDomainModel() },
            sprintQualifying: self.sprintQualifying.map { $0.toDomainModel() }
        )
    }
}

extension Session {
    func toDomainModel() -> SessionModel {
        return SessionModel(date: self.date ?? "", time: self.time ?? "")
    }
}
