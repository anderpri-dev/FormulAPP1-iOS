//
//  DriverDataModel.swift
//  FormulAPP1-test
//
//  Created by ANDER on 10/4/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1DriverMRDataRespuestaDataModel: Codable {
    let datos: MRDataType
    
    enum CodingKeys: String, CodingKey {
        case datos = "MRData"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let driverData = try? container.decode(F1DriverRespuestaDataModel.self, forKey: .datos) {
            datos = .Driver(driverData)
        }
        else {
            throw DecodingError.dataCorruptedError(forKey: .datos, in: container, debugDescription: "Invalid data format")
        }
    }
}

struct F1DriverRespuestaDataModel: Codable {
    let url: URL?
    let total: String
    let tablaPilotos: DriverTableDataModel
    
    enum CodingKeys: String, CodingKey {
        case url
        case total
        case tablaPilotos = "DriverTable"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        total = try container.decodeIfPresent(String.self, forKey: .total) ?? "0"
        tablaPilotos = try container.decodeIfPresent(DriverTableDataModel.self, forKey: .tablaPilotos)!
    }
}

// MARK: Objeto DriverTable

struct DriverTableDataModel: Codable {
    let temporada: String
    let listaPilotos: [DriverDataModel]

    enum CodingKeys: String, CodingKey {
        case temporada = "season"
        case listaPilotos = "Drivers"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temporada = try container.decodeIfPresent(String.self, forKey: .temporada) ?? ""
        listaPilotos = try container.decodeIfPresent([DriverDataModel].self, forKey: .listaPilotos) ?? []
    }
}

// MARK: Objeto Driver
    
struct DriverDataModel: Codable {
    let driverId: String
    let permanentNumber: String
    let code: String
    let url: URL?
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String

    enum CodingKeys: String, CodingKey {
        case driverId = "driverId"
        case permanentNumber = "permanentNumber"
        case code = "code"
        case url = "url"
        case givenName = "givenName"
        case familyName = "familyName"
        case dateOfBirth = "dateOfBirth"
        case nationality = "nationality"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        driverId = try container.decodeIfPresent(String.self, forKey: .driverId)!
        permanentNumber = try container.decodeIfPresent(String.self, forKey: .permanentNumber)!
        code = try container.decodeIfPresent(String.self, forKey: .code)!
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        givenName = try container.decodeIfPresent(String.self, forKey: .givenName)!
        familyName = try container.decodeIfPresent(String.self, forKey: .familyName)!
        dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth)!
        nationality = try container.decodeIfPresent(String.self, forKey: .nationality)!
    }
}

