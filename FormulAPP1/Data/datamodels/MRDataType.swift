//
//  MRDataType.swift
//  FormulAPP1
//
//  Created by ANDER on 10/4/25.
//

enum MRDataType: Codable {
    case Driver(F1DriverRespuestaDataModel)
    case Constructor(F1ConstructorRespuestaDataModel)
    case Race(F1RaceRespuestaDataModel)
    case DriverStandings(F1DriverStandingsRespuestaDataModel)
    case ConstructorStandings(F1ConstructorStandingsRespuestaDataModel)

    enum CodingKeys: String, CodingKey {
        case type
        case data
    }

    enum DataType: String, Codable {
        case driver
        case constructor
        case race
        case driverStandings
        case constructorStandings
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(DataType.self, forKey: .type)
        switch type {
        case .driver:
            let data = try container.decode(F1DriverRespuestaDataModel.self, forKey: .data)
            self = .Driver(data)
        case .constructor:
            let data = try container.decode(F1ConstructorRespuestaDataModel.self, forKey: .data)
            self = .Constructor(data)
        case .race:
            let data = try container.decode(F1RaceRespuestaDataModel.self, forKey: .data)
            self = .Race(data)
        case .driverStandings:
            let data = try container.decode(F1DriverStandingsRespuestaDataModel.self, forKey: .data)
            self = .DriverStandings(data)
        case .constructorStandings:
            let data = try container.decode(F1ConstructorStandingsRespuestaDataModel.self, forKey: .data)
            self = .ConstructorStandings(data)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .Driver(let data):
            try container.encode(DataType.driver, forKey: .type)
            try container.encode(data, forKey: .data)
        case .Constructor(let data):
            try container.encode(DataType.constructor, forKey: .type)
            try container.encode(data, forKey: .data)
        case .Race(let data):
            try container.encode(DataType.race, forKey: .type)
            try container.encode(data, forKey: .data)
        case .DriverStandings(let data):
            try container.encode(DataType.driverStandings, forKey: .type)
            try container.encode(data, forKey: .data)
        case .ConstructorStandings(let data):
            try container.encode(DataType.constructorStandings, forKey: .type)
            try container.encode(data, forKey: .data)
        }
    }
}
