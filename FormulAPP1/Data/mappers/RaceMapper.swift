//
//  RaceMapper.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import Foundation

// MARK: - Mapper de F1RaceMRDataRespuestaDataModel
extension F1RaceMRDataRespuestaDataModel {
    func parseToDomainModel() -> F1RaceMRDataRespuestaDomainModel {
        switch datos {
        case .Race(let raceData):
            .init(datos: .Race(raceData.parseToDomainModel()))
        default:
            fatalError("Tipo de datos no soportado en RaceMapper")
        }
    }
}

// MARK: - Mapper de F1RaceRespuestaDataModel
extension F1RaceRespuestaDataModel {
    func parseToDomainModel() -> F1RaceRespuestaDomainModel {
        .init(
            url: url,
            total: total,
            tablaCarreras: tablaCarreras.parseToDomainModel()
        )
    }
}

// MARK: - Mapper de RaceTableDataModel
extension RaceTableDataModel {
    func parseToDomainModel() -> RaceTableDomainModel {
        .init(
            temporada: temporada,
            listaCarreras: listaCarreras.map { $0.parseToDomainModel() }
        )
    }
}

// MARK: - Mapper de RaceDataModel
extension RaceDataModel {
    func parseToDomainModel() -> RaceDomainModel {
        .init(
            season: season,
            round: round,
            url: url,
            raceName: raceName,
            circuit: circuit.parseToDomainModel(),
            raceSession: SessionModel(date: date, time: time),
            firstPractice: firstPractice,
            secondPractice: secondPractice,
            thirdPractice: thirdPractice,
            qualifying: qualifying,
            sprint: sprint,
            sprintQualifying: sprintQualifying
        )
    }
}

// MARK: - Mapper de CircuitDataModel
extension CircuitDataModel {
    func parseToDomainModel() -> CircuitDomainModel {
        .init(
            circuitId: circuitId,
            url: url,
            circuitName: circuitName,
            location: location.parseToDomainModel()
        )
    }
}

// MARK: - Mapper de LocationDataModel
extension LocationDataModel {
    func parseToDomainModel() -> LocationDomainModel {
        .init(
            lat: lat,
            long: long,
            locality: locality,
            country: country
        )
    }
}
