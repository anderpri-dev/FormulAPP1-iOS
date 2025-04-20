//
//  DriverStandingsDomainModel.swift
//  FormulAPP1
//
//  Created by ANDER on 11/4/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1DriverStandingsMRDataRespuestaDomainModel {
    let datos: MRDataDomainType
}

struct F1DriverStandingsRespuestaDomainModel: Codable {
    let url: URL?
    let total: String
    let tablaPosiciones: DriverStandingsTableDomainModel
}

// MARK: - Objeto DriverStandingsTable

struct DriverStandingsTableDomainModel: Codable {
    let temporada: String
    let ronda: String
    let listaPosiciones: [DriverStandingsListDomainModel]
}

// MARK: - Objeto DriverStandingsList

struct DriverStandingsListDomainModel: Codable {
    let temporada: String
    let ronda: String
    let posicionesPilotos: [DriverStandingDomainModel]
}

// MARK: - Objeto DriverStandings

struct DriverStandingDomainModel: Codable, Hashable {
    let posicion: String
    let puntos: String
    let victorias: String
    let piloto: DriverDomainModel
    let constructores: [ConstructorDomainModel]
}
