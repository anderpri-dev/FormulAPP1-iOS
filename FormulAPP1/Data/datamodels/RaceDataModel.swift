//
//  Race.swift
//  FormulAPP1-test
//
//  Created by ANDER on 10/4/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1RaceMRDataRespuestaDataModel: Codable {
    let datos: MRDataType

    enum CodingKeys: String, CodingKey {
        case datos = "MRData"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let raceData = try? container.decode(F1RaceRespuestaDataModel.self, forKey: .datos) {
            datos = .Race(raceData)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .datos, in: container, debugDescription: "Invalid data format")
        }
    }
}

// MARK: Objeto F1RaceRespuesta

struct F1RaceRespuestaDataModel: Codable {
    let url: URL?
    let total: String
    let tablaCarreras: RaceTableDataModel

    enum CodingKeys: String, CodingKey {
        case url
        case total
        case tablaCarreras = "RaceTable"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        total = try container.decodeIfPresent(String.self, forKey: .total) ?? "0"
        tablaCarreras = try container.decode(RaceTableDataModel.self, forKey: .tablaCarreras)
    }
}

// MARK: RaceTable

struct RaceTableDataModel: Codable {
    let temporada: String
    let listaCarreras: [RaceDataModel]

    enum CodingKeys: String, CodingKey {
        case temporada = "season"
        case listaCarreras = "Races"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temporada = try container.decodeIfPresent(String.self, forKey: .temporada) ?? ""
        listaCarreras = try container.decodeIfPresent([RaceDataModel].self, forKey: .listaCarreras) ?? []
    }
}

// MARK: Race

struct RaceDataModel: Codable {
    let season: String
    let round: String
    let url: URL?
    let raceName: String
    let circuit: CircuitDataModel
    let date: String
    let time: String
    let firstPractice: SessionModel?
    let secondPractice: SessionModel?
    let thirdPractice: SessionModel?
    let qualifying: SessionModel?
    let sprint: SessionModel?
    let sprintQualifying: SessionModel?

    enum CodingKeys: String, CodingKey {
        case season, round, url, raceName, circuit = "Circuit"
        case date, time
        case firstPractice = "FirstPractice"
        case secondPractice = "SecondPractice"
        case thirdPractice = "ThirdPractice"
        case qualifying = "Qualifying"
        case sprint = "Sprint"
        case sprintQualifying = "SprintQualifying"
    }
}

// MARK: Circuit

struct CircuitDataModel: Codable {
    let circuitId: String
    let url: URL?
    let circuitName: String
    let location: LocationDataModel

    enum CodingKeys: String, CodingKey {
        case circuitId
        case url
        case circuitName
        case location = "Location"
    }
}

// MARK: Location

struct LocationDataModel: Codable {
    let lat: String
    let long: String
    let locality: String
    let country: String
}
