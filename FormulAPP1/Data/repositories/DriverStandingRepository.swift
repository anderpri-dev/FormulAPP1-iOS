//
//  DriverStandingRepository.swift
//  FormulAPP1
//
//  Created by ANDER on 30/4/25.
//

import Foundation
import CoreData

final class DriverStandingRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    static let shared = DriverStandingRepository()

    func save(from domainModel: DriverStandingDomainModel) throws {
        let standing = DriverStanding(context: context)
        standing.posicion = domainModel.posicion
        standing.puntos = domainModel.puntos
        standing.victorias = domainModel.victorias
        
        // Recuperar o guardar Driver
        // utilizamos la extensión fetchOrCreate
        let driverModel = domainModel.piloto
        let driver = try context.fetchOrCreate(
            entity: Driver.self,
            predicate: NSPredicate(format: "driverId == %@", driverModel.driverId)
        ) { newDriver in
            newDriver.driverId = driverModel.driverId
            newDriver.permanentNumber = driverModel.permanentNumber
            newDriver.code = driverModel.code
            newDriver.url = driverModel.url
            newDriver.givenName = driverModel.givenName
            newDriver.familyName = driverModel.familyName
            newDriver.dateOfBirth = driverModel.dateOfBirth
            newDriver.nationality = driverModel.nationality
        }
        
        standing.piloto = driver
        
        // Recuperar o guardar Constructor
        for constructorModel in domainModel.constructores {
            let constructor = try context.fetchOrCreate(
                entity: Constructor.self,
                predicate: NSPredicate(format: "constructorId == %@", constructorModel.constructorId)
            ) { newConstructor in
                newConstructor.constructorId = constructorModel.constructorId
                newConstructor.nombre = constructorModel.nombre
                newConstructor.nacionalidad = constructorModel.nacionalidad
                newConstructor.url = constructorModel.url
            }
            
            standing.addToConstructores(constructor)
        }
        
        try context.save()
    }

    func fetchAll() throws -> [DriverStandingDomainModel] {
        let fetchRequest: NSFetchRequest<DriverStanding> = DriverStanding.fetchRequest()
        let results = try context.fetch(fetchRequest)
        return results.compactMap { $0.toDomainModel() }
    }
    
    func fetchByDriverId(_ driverId: String) throws -> DriverStandingDomainModel? {
        let fetchRequest: NSFetchRequest<DriverStanding> = DriverStanding.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "piloto.driverId == %@", driverId)
        fetchRequest.fetchLimit = 1
        
        let result = try context.fetch(fetchRequest).first
        return result?.toDomainModel()
    }
    
    
    func deleteAll() throws {
        let standings = try context.fetch(DriverStanding.fetchRequest())

        for standing in standings {
            // Limpia relaciones inversas
            standing.constructores?.forEach { constructor in
                (constructor as? Constructor)?.removeFromDriverStandings(standing)
            }
            standing.piloto?.driverStanding = nil
            context.delete(standing)
        }

        try context.save()
    }
}


extension DriverStanding {
    func toDomainModel() -> DriverStandingDomainModel? {
        guard let driver = self.piloto else { return nil }

        let constructoresMapped = (self.constructores as? Set<Constructor>)?.compactMap {
            ConstructorDomainModel(
                constructorId: $0.constructorId ?? "",
                url: $0.url,
                nombre: $0.nombre ?? "",
                nacionalidad: $0.nacionalidad ?? ""
            )
        } ?? []

        return DriverStandingDomainModel(
            posicion: self.posicion ?? "-",
            puntos: self.puntos ?? "0",
            victorias: self.victorias ?? "0",
            piloto: DriverDomainModel(
                driverId: driver.driverId ?? "",
                permanentNumber: driver.permanentNumber ?? "",
                code: driver.code ?? "",
                url: driver.url,
                givenName: driver.givenName ?? "",
                familyName: driver.familyName ?? "",
                dateOfBirth: driver.dateOfBirth ?? "",
                nationality: driver.nationality ?? ""
            ),
            constructores: constructoresMapped
        )
    }
}


// NSManagedObjectContext+Extensions.swift

// Extensión para buscar o crear objetos en Core Data
// Si existe -> se recupera
// Si no existe -> se crea
extension NSManagedObjectContext {
    func fetchOrCreate<T: NSManagedObject>(
        entity: T.Type,
        predicate: NSPredicate,
        configure: (T) -> Void
    ) throws -> T {
        let fetchRequest = T.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1

        if let result = try self.fetch(fetchRequest).first as? T {
            return result
        } else {
            let newObject = T(context: self)
            configure(newObject)
            return newObject
        }
    }
}
