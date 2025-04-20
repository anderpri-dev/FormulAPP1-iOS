//
//  DriverStandingsMapper.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import Foundation

// MARK: - Mapper de F1DriverStandingsMRDataRespuestaDataModel
extension F1DriverStandingsMRDataRespuestaDataModel {
    func parseToDomainModel() -> F1DriverStandingsMRDataRespuestaDomainModel {
        switch datos {
        case .DriverStandings(let standingsData):
            return .init(datos: .DriverStandings(standingsData.parseToDomainModel()))
        default:
            fatalError("Tipo de datos no soportado en DriverStandingsMapper")
        }
    }
}

// MARK: - Mapper de F1DriverStandingsRespuestaDataModel
extension F1DriverStandingsRespuestaDataModel {
    func parseToDomainModel() -> F1DriverStandingsRespuestaDomainModel {
        .init(
            url: url,
            total: total,
            tablaPosiciones: tablaPosiciones.parseToDomainModel()
        )
    }
}

// MARK: - Mapper de DriverStandingsTableDataModel
extension DriverStandingsTableDataModel {
    func parseToDomainModel() -> DriverStandingsTableDomainModel {
        .init(
            temporada: temporada,
            ronda: ronda,
            listaPosiciones: listaPosiciones.map { $0.parseToDomainModel() }
        )
    }
}

// MARK: - Mapper de DriverStandingsListDataModel
extension DriverStandingsListDataModel {
    func parseToDomainModel() -> DriverStandingsListDomainModel {
        .init(
            temporada: temporada,
            ronda: ronda,
            posicionesPilotos: posicionesPilotos.map { $0.parseToDomainModel() }
        )
    }
}

// MARK: - Mapper de DriverStandingDataModel
extension DriverStandingDataModel {
    func parseToDomainModel() -> DriverStandingDomainModel {
        .init(
            posicion: posicion,
            puntos: puntos,
            victorias: victorias,
            piloto: piloto.parseToDomainModel(),
            constructores: constructores.map { $0.parseToDomainModel() }
        )
    }
}
