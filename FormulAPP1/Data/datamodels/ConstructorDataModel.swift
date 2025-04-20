//
//  ConstructorDataModel.swift
//  FormulAPP1
//
//  Created by ANDER on 29/4/25.
//

import Foundation

// MARK: - Para procesar los datos de Constructores desde la API

struct F1ConstructorMRDataRespuestaDataModel: Codable {
    let datos: MRDataType

    enum CodingKeys: String, CodingKey {
        case datos = "MRData"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let constructorData = try? container.decode(F1ConstructorRespuestaDataModel.self, forKey: .datos) {
            datos = .Constructor(constructorData)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .datos, in: container, debugDescription: "Invalid data format")
        }
    }
}

struct F1ConstructorRespuestaDataModel: Codable {
    let url: URL?
    let total: String
    let tablaConstructores: ConstructorTableDataModel

    enum CodingKeys: String, CodingKey {
        case url
        case total
        case tablaConstructores = "ConstructorTable"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        url = try container.decodeIfPresent(URL.self, forKey: .url)
        total = try container.decodeIfPresent(String.self, forKey: .total) ?? "0"
        tablaConstructores = try container.decode(ConstructorTableDataModel.self, forKey: .tablaConstructores)
    }
}

// MARK: Objeto ConstructorTable

struct ConstructorTableDataModel: Codable {
    let temporada: String
    let listaConstructores: [ConstructorDataModel]

    enum CodingKeys: String, CodingKey {
        case temporada = "season"
        case listaConstructores = "Constructors"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        temporada = try container.decodeIfPresent(String.self, forKey: .temporada) ?? ""
        listaConstructores = try container.decodeIfPresent([ConstructorDataModel].self, forKey: .listaConstructores) ?? []
    }
}

// MARK: Constructor

struct ConstructorDataModel: Codable {
    let constructorId: String
    let url: URL?
    let nombre: String
    let nacionalidad: String

    enum CodingKeys: String, CodingKey {
        case constructorId
        case url
        case nombre = "name"
        case nacionalidad = "nationality"
    }
}
