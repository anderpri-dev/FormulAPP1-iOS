//
//  DriverDomainModel.swift
//  FormulAPP1
//
//  Created by ANDER on 10/4/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1DriverMRDataRespuestaDomainModel {
    let datos: MRDataDomainType
}

struct F1DriverRespuestaDomainModel: Codable {
    let url: URL?
    let total: String
    let tablaPilotos: DriverTableDomainModel
}

// MARK: Objeto DriverTable

struct DriverTableDomainModel: Codable {
    let temporada: String
    let listaPilotos: [DriverDomainModel]
}

// MARK: Objeto Driver

struct DriverDomainModel: Codable, Equatable, Hashable {
    let driverId: String
    let permanentNumber: String
    let code: String
    let url: URL?
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String
}

extension DriverDomainModel {
    init(from driver: Driver) {
        self.driverId = driver.driverId ?? ""
        self.permanentNumber = driver.permanentNumber ?? ""
        self.code = driver.code ?? ""
        self.givenName = driver.givenName ?? ""
        self.familyName = driver.familyName ?? ""
        self.dateOfBirth = driver.dateOfBirth ?? ""
        self.nationality = driver.nationality ?? ""
        self.url = driver.url
    }
}
