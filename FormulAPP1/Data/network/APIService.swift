//
//  APIService.swift
//  FormulAPP1-test
//
//  Created by ANDER on 7/4/25.
//

import Foundation
import Alamofire

typealias PeticionDriverF1 = (Result<F1DriverMRDataRespuestaDomainModel, Error>) -> Void
typealias PeticionConstructorF1 = (Result<F1ConstructorMRDataRespuestaDomainModel, Error>) -> Void
typealias PeticionStandingsF1 = (Result<F1DriverStandingsMRDataRespuestaDomainModel, Error>) -> Void
typealias PeticionConstructorStandingsF1 = (Result<F1ConstructorStandingsMRDataRespuestaDomainModel, Error>) -> Void
typealias PeticionRaceF1 = (Result<F1RaceMRDataRespuestaDomainModel, Error>) -> Void


class APIService {
    static let shared = APIService()
    
    let endpointDrivers: String = "https://api.jolpi.ca/ergast/f1/2025/drivers/?format=json"
    let endpointConstructors: String = "https://api.jolpi.ca/ergast/f1/2025/constructors/?format=json"
    let endpointDriverStandings: String = "https://api.jolpi.ca/ergast/f1/2025/driverstandings/?format=json"
    let endpointConstructorStandings: String = "https://api.jolpi.ca/ergast/f1/2025/constructorstandings/?format=json"
    let endpointRaces: String = "https://api.jolpi.ca/ergast/f1/2025/races/?format=json"
    
    func fetchDrivers(completionHandler: @escaping PeticionDriverF1){
        AF.request(endpointDrivers).validate().cURLDescription() { curl in
            print(curl)
        }.responseDecodable(of: F1DriverMRDataRespuestaDataModel.self) { dataResponse in
            switch dataResponse.result {
            case .success(let respuestaOK):
                completionHandler(.success(respuestaOK.parseToDomainModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchConstructors(completionHandler: @escaping PeticionConstructorF1){
        AF.request(endpointConstructors).validate().cURLDescription() { curl in
            print(curl)
        }.responseDecodable(of: F1ConstructorMRDataRespuestaDataModel.self) { dataResponse in
            switch dataResponse.result {
            case .success(let respuestaOK):
                completionHandler(.success(respuestaOK.parseToDomainModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchDriverStandings(completionHandler: @escaping PeticionStandingsF1){
        AF.request(endpointDriverStandings).validate().cURLDescription() { curl in
            print(curl)
        }.responseDecodable(of: F1DriverStandingsMRDataRespuestaDataModel.self) { dataResponse in
            switch dataResponse.result {
            case .success(let respuestaOK):
                completionHandler(.success(respuestaOK.parseToDomainModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchConstructorStandings(completionHandler: @escaping PeticionConstructorStandingsF1){
        AF.request(endpointConstructorStandings).validate().cURLDescription() { curl in
            print(curl)
        }.responseDecodable(of: F1ConstructorStandingsMRDataRespuestaDataModel.self) { dataResponse in
            switch dataResponse.result {
            case .success(let respuestaOK):
                completionHandler(.success(respuestaOK.parseToDomainModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchRaces(completionHandler: @escaping PeticionRaceF1){
        AF.request(endpointRaces).validate().cURLDescription() { curl in
            print(curl)
        }.responseDecodable(of: F1RaceMRDataRespuestaDataModel.self) { dataResponse in
            switch dataResponse.result {
            case .success(let respuestaOK):
                completionHandler(.success(respuestaOK.parseToDomainModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }


}
