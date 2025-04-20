//
//  WidgetViewModel.swift
//  FormulAPP1
//
//  Created by ANDER on 9/5/25.
//


import Foundation

class WidgetViewModel: ObservableObject {
    private let widgetRepository: WidgetRepository
    
    init() {
        self.widgetRepository = WidgetRepository.shared
    }
    
    func getDriverStandingById(driverId: String) -> DriverStandingDomainModel? {
        try? widgetRepository.fetchByDriverId(driverId)
    }

    func getConstructorStandingById(constructorId: String) -> ConstructorStandingDomainModel? {
        try? widgetRepository.fetchByConstructorId(constructorId)
    }
}

