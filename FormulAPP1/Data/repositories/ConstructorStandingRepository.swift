//
//  ConstructorStandingRepository.swift
//  FormulAPP1
//
//  Created by ANDER on 30/4/25.
//

import Foundation
import CoreData

final class ConstructorStandingRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    static let shared = ConstructorStandingRepository()

    func save(from domainModel: ConstructorStandingDomainModel) throws {
        let standing = ConstructorStanding(context: context)
        standing.posicion = domainModel.posicion
        standing.puntos = domainModel.puntos
        standing.victorias = domainModel.victorias

        // Crear o buscar constructor
        let constructorModel = domainModel.constructor
        let constructor = try context.fetchOrCreate(
            entity: Constructor.self,
            predicate: NSPredicate(format: "constructorId == %@", constructorModel.constructorId)
        ) { newConstructor in
            newConstructor.constructorId = constructorModel.constructorId
            newConstructor.nombre = constructorModel.nombre
            newConstructor.nacionalidad = constructorModel.nacionalidad
            newConstructor.url = constructorModel.url
        }

        standing.constructor = constructor

        try context.save()
    }
    
    func fetchAll() throws -> [ConstructorStandingDomainModel] {
        let fetchRequest: NSFetchRequest<ConstructorStanding> = ConstructorStanding.fetchRequest()
        let results = try context.fetch(fetchRequest)
        return results.map { $0.toDomainModel() }
    }
    
    
    func fetchByConstructorId(_ constructorId: String) throws -> ConstructorStandingDomainModel? {
        let fetchRequest: NSFetchRequest<ConstructorStanding> = ConstructorStanding.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "constructor.constructorId == %@", constructorId)
        fetchRequest.fetchLimit = 1
        
        let result = try context.fetch(fetchRequest).first
        return result?.toDomainModel()
    }

    func deleteAll() throws {
        let standings = try context.fetch(ConstructorStanding.fetchRequest())

        for standing in standings {
            standing.constructor?.removeFromConstructorStandings(standing)
            context.delete(standing)
        }

        try context.save()
    }
}


extension ConstructorStanding {
    func toDomainModel() -> ConstructorStandingDomainModel {
        let constructorModel = ConstructorDomainModel(
            constructorId: self.constructor?.constructorId ?? "",
            url: self.constructor?.url,
            nombre: self.constructor?.nombre ?? "",
            nacionalidad: self.constructor?.nacionalidad ?? ""
        )
        
        return ConstructorStandingDomainModel(
            posicion: self.posicion ?? "",
            posicionTexto: self.posicionTexto ?? "",
            puntos: self.puntos ?? "",
            victorias: self.victorias ?? "",
            constructor: constructorModel
        )
    }
}
