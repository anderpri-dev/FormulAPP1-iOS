//
//  DriverStandingsDataModel.swift
//  FormulAPP1
//
//  Created by ANDER on 11/4/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1DriverStandingsMRDataRespuestaDataModel: Codable {
    let datos: MRDataType

    enum CodingKeys: String, CodingKey {
        case datos = "MRData"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let standingsData = try? container.decode(F1DriverStandingsRespuestaDataModel.self, forKey: .datos) {
            datos = .DriverStandings(standingsData)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .datos, in: container, debugDescription: "Invalid data format")
        }
    }
}

struct F1DriverStandingsRespuestaDataModel: Codable {
    let url: URL?
    let total: String
    let tablaPosiciones: DriverStandingsTableDataModel

    enum CodingKeys: String, CodingKey {
        case url
        case total
        case tablaPosiciones = "StandingsTable"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        total = try container.decodeIfPresent(String.self, forKey: .total) ?? "0"
        tablaPosiciones = try container.decodeIfPresent(DriverStandingsTableDataModel.self, forKey: .tablaPosiciones)!
    }
}

// MARK: - Objeto DriverStandingsTable

struct DriverStandingsTableDataModel: Codable {
    let temporada: String
    let ronda: String
    let listaPosiciones: [DriverStandingsListDataModel]

    enum CodingKeys: String, CodingKey {
        case temporada = "season"
        case ronda = "round"
        case listaPosiciones = "StandingsLists"
    }
}

// MARK: - Objeto DriverStandingsList

struct DriverStandingsListDataModel: Codable {
    let temporada: String
    let ronda: String
    let posicionesPilotos: [DriverStandingDataModel]

    enum CodingKeys: String, CodingKey {
        case temporada = "season"
        case ronda = "round"
        case posicionesPilotos = "DriverStandings"
    }
}

// MARK: - Objeto DriverStandings

struct DriverStandingDataModel: Codable {
    let posicion: String
    let puntos: String
    let victorias: String
    let piloto: DriverDataModel
    let constructores: [ConstructorDataModel]

    enum CodingKeys: String, CodingKey {
        case posicion = "position"
        case puntos = "points"
        case victorias = "wins"
        case piloto = "Driver"
        case constructores = "Constructors"
    }
}


