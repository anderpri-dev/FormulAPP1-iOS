//
//  ConstructorStandingsMapper.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import Foundation

// MARK: - Mapper de F1ConstructorStandingsMRDataRespuestaDataModel
extension F1ConstructorStandingsMRDataRespuestaDataModel {
    func parseToDomainModel() -> F1ConstructorStandingsMRDataRespuestaDomainModel {
        switch datos {
        case .ConstructorStandings(let standingsData):
            return .init(datos: .ConstructorStandings(standingsData.parseToDomainModel()))
        default:
            fatalError("Tipo de datos no soportado en ConstructorStandingsMapper")
        }
    }
}

// MARK: - Mapper de F1ConstructorStandingsRespuestaDataModel
extension F1ConstructorStandingsRespuestaDataModel {
    func parseToDomainModel() -> F1ConstructorStandingsRespuestaDomainModel {
        .init(
            url: url,
            total: total,
            tablaPosiciones: tablaPosiciones.parseToDomainModel()
        )
    }
}

// MARK: - Mapper de ConstructorStandingsTableDataModel
extension ConstructorStandingsTableDataModel {
    func parseToDomainModel() -> ConstructorStandingsTableDomainModel {
        .init(
            temporada: temporada,
            ronda: ronda,
            listaPosiciones: listaPosiciones.map { $0.parseToDomainModel() }
        )
    }
}

// MARK: - Mapper de ConstructorStandingsListDataModel
extension ConstructorStandingsListDataModel {
    func parseToDomainModel() -> ConstructorStandingsListDomainModel {
        .init(
            temporada: temporada,
            ronda: ronda,
            posicionesConstructores: posicionesConstructores.map { $0.parseToDomainModel() }
        )
    }
}

// MARK: - Mapper de ConstructorStandingDataModel
extension ConstructorStandingDataModel {
    func parseToDomainModel() -> ConstructorStandingDomainModel {
        .init(
            posicion: posicion,
            posicionTexto: posicionTexto,
            puntos: puntos,
            victorias: victorias,
            constructor: constructor.parseToDomainModel()
        )
    }
}
