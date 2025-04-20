//
//  SampleData.swift
//  FormulAPP1
//
//  Created by ANDER on 5/5/25.
//


import Foundation

let sampleDriver = DriverDomainModel(
    driverId: "max_verstappen_sample",
    permanentNumber: "33",
    code: "VER",
    url: nil,
    givenName: "Max",
    familyName: "Verstappen",
    dateOfBirth: "1997-09-30",
    nationality: "Dutch"
)

let sampleConstructor = ConstructorDomainModel(
    constructorId: "red_bull_sample",
    url: nil,
    nombre: "Red Bull Racing",
    nacionalidad: "Austrian"
)

let sampleStandingDriver = DriverStandingDomainModel(
    posicion: "1",
    puntos: "200",
    victorias: "",
    piloto: sampleDriver,
    constructores: [sampleConstructor]
)

let sampleStandingConstructor = ConstructorStandingDomainModel(
    posicion: "1",
    posicionTexto: "1",
    puntos: "250",
    victorias: "10",
    constructor: sampleConstructor
)

let sampleRace = RaceDomainModel(
    season: "2025",
    round: "1",
    url: URL(string: "https://en.wikipedia.org/wiki/2025_Australian_Grand_Prix"),
    raceName: "Australian Grand Prix",
    circuit: CircuitDomainModel(
        circuitId: "albert_park",
        url: URL(string: "https://en.wikipedia.org/wiki/Albert_Park_Circuit"),
        circuitName: "Albert Park Grand Prix Circuit",
        location: LocationDomainModel(
            lat: "-37.8497",
            long: "144.968",
            locality: "Melbourne",
            country: "Australia"
        )
    ),
    raceSession: SessionModel(
        date: "2025-03-16",
        time: "04:00:00Z"
    ),
    firstPractice: SessionModel(
        date: "2025-03-14",
        time: "01:30:00Z"
    ),
    secondPractice: SessionModel(
        date: "2025-03-14",
        time: "05:00:00Z"
    ),
    thirdPractice: SessionModel(
        date: "2025-03-15",
        time: "01:30:00Z"
    ),
    qualifying: SessionModel(
        date: "2025-03-15",
        time: "05:00:00Z"
    ),
    sprint: nil,
    sprintQualifying: nil
)
