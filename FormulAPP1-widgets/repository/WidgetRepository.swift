//
//  ConstructorStandingRepository.swift
//  FormulAPP1
//
//  Created by ANDER on 9/5/25.
//

import Foundation
import CoreData

final class WidgetRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    static let shared = WidgetRepository()
    
    func fetchByDriverId(_ driverId: String) throws -> DriverStandingDomainModel? {

        let fetchRequest: NSFetchRequest<DriverStanding> = DriverStanding.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "piloto.driverId == %@", driverId)
        fetchRequest.fetchLimit = 1

        let results = try context.fetch(fetchRequest)

        guard let standing = results.first, let driver = standing.piloto else {
            return nil
        }

        let mappedConstructores: [ConstructorDomainModel] = (standing.constructores as? Set<Constructor>)?.compactMap {
            ConstructorDomainModel(
                constructorId: $0.constructorId ?? "",
                url: $0.url,
                nombre: $0.nombre ?? "",
                nacionalidad: $0.nacionalidad ?? ""
            )
        } ?? []

        return DriverStandingDomainModel(
            posicion: standing.posicion ?? "-",
            puntos: standing.puntos ?? "0",
            victorias: standing.victorias ?? "0",
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
            constructores: mappedConstructores
        )
    }
    
    func fetchByConstructorId(_ constructorId: String) throws -> ConstructorStandingDomainModel? {

        let fetchRequest: NSFetchRequest<ConstructorStanding> = ConstructorStanding.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "constructor.constructorId == %@", constructorId)
        fetchRequest.fetchLimit = 1
        
        let results = try context.fetch(fetchRequest)

        guard let standing = results.first, let constructor = standing.constructor else {
            return nil
        }
        
        return ConstructorStandingDomainModel(
            posicion: standing.posicion ?? "-",
            posicionTexto: standing.posicionTexto ?? "-",
            puntos: standing.puntos ?? "0",
            victorias: standing.victorias ?? "0",
            constructor: ConstructorDomainModel(
                constructorId: constructor.constructorId ?? "",
                url: constructor.url,
                nombre: constructor.nombre ?? "",
                nacionalidad: constructor.nacionalidad ?? ""
            )
        )
    }
}

