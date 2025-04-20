//
//  MRDataDomainType.swift
//  FormulAPP1
//
//  Created by ANDER on 10/4/25.
//

enum MRDataDomainType {
    case Driver(F1DriverRespuestaDomainModel)
    case Constructor(F1ConstructorRespuestaDomainModel)
    case Race(F1RaceRespuestaDomainModel)
    case DriverStandings(F1DriverStandingsRespuestaDomainModel)
    case ConstructorStandings(F1ConstructorStandingsRespuestaDomainModel)
}
