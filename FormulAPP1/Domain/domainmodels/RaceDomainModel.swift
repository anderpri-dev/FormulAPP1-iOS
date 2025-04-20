//
//  Race.swift
//  FormulAPP1-test
//
//  Created by ANDER on 10/4/25.
//

import Foundation

// MARK: Para procesar los datos de la API

struct F1RaceMRDataRespuestaDomainModel {
    let datos: MRDataDomainType
}

// MARK: Objeto F1RaceRespuesta

struct F1RaceRespuestaDomainModel: Codable {
    let url: URL?
    let total: String
    let tablaCarreras: RaceTableDomainModel
}

// MARK: RaceTable

struct RaceTableDomainModel: Codable {
    let temporada: String
    let listaCarreras: [RaceDomainModel]
}

// MARK: Race

struct RaceDomainModel: Codable, Equatable, Hashable {
    let season: String
    let round: String
    let url: URL?
    let raceName: String
    let circuit: CircuitDomainModel
    let raceSession: SessionModel
    let firstPractice: SessionModel?
    let secondPractice: SessionModel?
    let thirdPractice: SessionModel?
    let qualifying: SessionModel?
    let sprint: SessionModel?
    let sprintQualifying: SessionModel?
}

extension RaceDomainModel {
    init(from race: Race) {
        self.season = race.season ?? ""
        self.round = race.round ?? ""
        self.url = race.url
        self.raceName = race.raceName ?? ""

        let circuit = race.circuit
        let location = circuit?.location

        self.circuit = CircuitDomainModel(
            circuitId: circuit?.circuitId ?? "",
            url: circuit?.url,
            circuitName: circuit?.circuitName ?? "",
            location: LocationDomainModel(
                lat: location?.lat ?? "",
                long: location?.long ?? "",
                locality: location?.locality ?? "",
                country: location?.country ?? ""
            )
        )

        self.raceSession = SessionModel(
            date: race.raceSession?.date ?? "",
            time: race.raceSession?.time ?? ""
        )

        self.firstPractice = race.firstPractice.flatMap {
            SessionModel(date: $0.date ?? "", time: $0.time ?? "")
        }
        self.secondPractice = race.secondPractice.flatMap {
            SessionModel(date: $0.date ?? "", time: $0.time ?? "")
        }
        self.thirdPractice = race.thirdPractice.flatMap {
            SessionModel(date: $0.date ?? "", time: $0.time ?? "")
        }
        self.qualifying = race.qualifying.flatMap {
            SessionModel(date: $0.date ?? "", time: $0.time ?? "")
        }
        self.sprint = race.sprint.flatMap {
            SessionModel(date: $0.date ?? "", time: $0.time ?? "")
        }
        self.sprintQualifying = race.sprintQualifying.flatMap {
            SessionModel(date: $0.date ?? "", time: $0.time ?? "")
        }
    }
}

// MARK: Circuit

struct CircuitDomainModel: Codable, Equatable, Hashable {
    let circuitId: String
    let url: URL?
    let circuitName: String
    let location: LocationDomainModel
}

// MARK: Location

struct LocationDomainModel: Codable, Equatable, Hashable {
    let lat: String
    let long: String
    let locality: String
    let country: String
}

// MARK: Session

struct SessionModel: Codable, Equatable, Hashable {
    let date: String
    let time: String
}

extension CircuitDomainModel {
    init(from circuit: CircuitDataModel) {
        self.circuitId = circuit.circuitId
        self.url = circuit.url
        self.circuitName = circuit.circuitName
        self.location = LocationDomainModel(from: circuit.location)
    }
}

extension LocationDomainModel {
    init(from location: LocationDataModel) {
        self.lat = location.lat
        self.long = location.long
        self.locality = location.locality
        self.country = location.country
    }
}
