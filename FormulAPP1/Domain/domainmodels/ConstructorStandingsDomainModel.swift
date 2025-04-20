//
//  ConstructorStandings.swift
//  FormulAPP1
//
//  Created by ANDER on 30/4/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1ConstructorStandingsMRDataRespuestaDomainModel {
    let datos: MRDataDomainType
}

struct F1ConstructorStandingsRespuestaDomainModel: Codable {
    let url: URL?
    let total: String
    let tablaPosiciones: ConstructorStandingsTableDomainModel
}

// MARK: - Objeto ConstructorStandingsTable

struct ConstructorStandingsTableDomainModel: Codable {
    let temporada: String
    let ronda: String
    let listaPosiciones: [ConstructorStandingsListDomainModel]
}
// MARK: - Objeto ConstructorStandingsList

struct ConstructorStandingsListDomainModel: Codable {
    let temporada: String
    let ronda: String
    let posicionesConstructores: [ConstructorStandingDomainModel]
}

// MARK: - Objeto ConstructorStandings

struct ConstructorStandingDomainModel: Codable, Hashable {
    let posicion: String
    let posicionTexto: String
    let puntos: String
    let victorias: String
    let constructor: ConstructorDomainModel
}
