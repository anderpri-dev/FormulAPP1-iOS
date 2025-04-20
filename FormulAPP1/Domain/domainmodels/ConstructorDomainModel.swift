//
//  Constructor.swift
//  FormulAPP1
//
//  Created by ANDER on 29/4/25.
//

import Foundation

// MARK: - Para procesar los datos de Constructores desde la API

struct F1ConstructorMRDataRespuestaDomainModel {
    let datos: MRDataDomainType
}

struct F1ConstructorRespuestaDomainModel: Codable {
    let url: URL?
    let total: String
    let tablaConstructores: ConstructorTableDomainModel
}

// MARK: Objeto ConstructorTable

struct ConstructorTableDomainModel: Codable {
    let temporada: String
    let listaConstructores: [ConstructorDomainModel]
}

// MARK: Constructor

struct ConstructorDomainModel: Codable, Equatable, Hashable {
    let constructorId: String
    let url: URL?
    let nombre: String
    let nacionalidad: String
}
