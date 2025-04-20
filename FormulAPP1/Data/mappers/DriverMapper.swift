//
//  DriverMapper.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import Foundation

// MARK: - Mapper de F1DriverMRDataRespuestaDataModel
extension F1DriverMRDataRespuestaDataModel {
    func parseToDomainModel() -> F1DriverMRDataRespuestaDomainModel {
        switch datos {
        case .Driver(let driverData):
            return .init(datos: .Driver(driverData.parseToDomainModel()))
        default:
            fatalError("Tipo de datos no soportado en DriverMapper")
        }
    }
}

// MARK: - Mapper de F1DriverRespuestaDataModel
extension F1DriverRespuestaDataModel {
    func parseToDomainModel() -> F1DriverRespuestaDomainModel {
        .init(
            url: url,
            total: total,
            tablaPilotos: tablaPilotos.parseToDomainModel()
        )
    }
}

// MARK: - Mapper de DriverTableDataModel
extension DriverTableDataModel {
    func parseToDomainModel() -> DriverTableDomainModel {
        .init(
            temporada: temporada,
            listaPilotos: listaPilotos.map { $0.parseToDomainModel() }
        )
    }
}

// MARK: - Mapper de DriverDataModel
extension DriverDataModel {
    func parseToDomainModel() -> DriverDomainModel {
        .init(
            driverId: driverId,
            permanentNumber: permanentNumber,
            code: code,
            url: url,
            givenName: givenName,
            familyName: familyName,
            dateOfBirth: dateOfBirth,
            nationality: nationality
        )
    }
}
