//
//  ConstructorMapper.swift
//  FormulAPP1
//
//  Created by ANDER on 17/5/25.
//

import Foundation

// MARK: - Mapper de F1ConstructorMRDataRespuestaDataModel
extension F1ConstructorMRDataRespuestaDataModel {
    func parseToDomainModel() -> F1ConstructorMRDataRespuestaDomainModel {
        switch datos {
        case .Constructor(let constructorData):
            return .init(datos: .Constructor(constructorData.parseToDomainModel()))
        default:
            fatalError("Tipo de datos no soportado en ConstructorMapper")
        }
    }
}

// MARK: - Mapper de F1ConstructorRespuestaDataModel
extension F1ConstructorRespuestaDataModel {
    func parseToDomainModel() -> F1ConstructorRespuestaDomainModel {
        .init(
            url: url,
            total: total,
            tablaConstructores: tablaConstructores.parseToDomainModel()
        )
    }
}

// MARK: - Mapper de ConstructorTableDataModel
extension ConstructorTableDataModel {
    func parseToDomainModel() -> ConstructorTableDomainModel {
        .init(
            temporada: temporada,
            listaConstructores: listaConstructores.map { $0.parseToDomainModel() }
        )
    }
}

// MARK: - Mapper de ConstructorDataModel
extension ConstructorDataModel {
    func parseToDomainModel() -> ConstructorDomainModel {
        .init(
            constructorId: constructorId,
            url: url,
            nombre: nombre,
            nacionalidad: nacionalidad
        )
    }
}
