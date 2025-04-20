//
//  ConstructorStandingsDataModel.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1ConstructorStandingsMRDataRespuestaDataModel: Codable {
    let datos: MRDataType

    enum CodingKeys: String, CodingKey {
        case datos = "MRData"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let standingsData = try? container.decode(F1ConstructorStandingsRespuestaDataModel.self, forKey: .datos) {
            datos = .ConstructorStandings(standingsData)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .datos, in: container, debugDescription: "Invalid data format")
        }
    }
}

struct F1ConstructorStandingsRespuestaDataModel: Codable {
    let url: URL?
    let total: String
    let tablaPosiciones: ConstructorStandingsTableDataModel

    enum CodingKeys: String, CodingKey {
        case url
        case total
        case tablaPosiciones = "StandingsTable"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        total = try container.decodeIfPresent(String.self, forKey: .total) ?? "0"
        tablaPosiciones = try container.decodeIfPresent(ConstructorStandingsTableDataModel.self, forKey: .tablaPosiciones)!
    }
}

// MARK: - Objeto ConstructorStandingsTable

struct ConstructorStandingsTableDataModel: Codable {
    let temporada: String
    let ronda: String
    let listaPosiciones: [ConstructorStandingsListDataModel]

    enum CodingKeys: String, CodingKey {
        case temporada = "season"
        case ronda = "round"
        case listaPosiciones = "StandingsLists"
    }
}

// MARK: - Objeto ConstructorStandingsList

struct ConstructorStandingsListDataModel: Codable {
    let temporada: String
    let ronda: String
    let posicionesConstructores: [ConstructorStandingDataModel]

    enum CodingKeys: String, CodingKey {
        case temporada = "season"
        case ronda = "round"
        case posicionesConstructores = "ConstructorStandings"
    }
}

// MARK: - Objeto ConstructorStandings

struct ConstructorStandingDataModel: Codable {
    let posicion: String
    let posicionTexto: String
    let puntos: String
    let victorias: String
    let constructor: ConstructorDataModel

    enum CodingKeys: String, CodingKey {
        case posicion = "position"
        case posicionTexto = "positionText"
        case puntos = "points"
        case victorias = "wins"
        case constructor = "Constructor"
    }
}
