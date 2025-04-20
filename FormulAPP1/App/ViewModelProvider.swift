//
//  ViewModelProvider.swift
//  FormulAPP1
//
//  Created by ANDER on 9/5/25.
//


import Foundation

final class ViewModelProvider {
    static let shared = ViewModelProvider()

    let driversVM = DriversViewModel()
    let constructorsVM = ConstructorsViewModel()
    let racesVM = RacesViewModel()

    private let scheduler = DailyScheduler()

    private init() {
        // Configuramos el horario de actualización
        let time = (hour: 0, minutes: 0, seconds: 0)
        scheduler.scheduleDaily(time: time) {
            self.fetchAllData()
        }
    }
    
    func fetchAllData() {
        driversVM.fetchStandings()
        constructorsVM.fetchStandings()
        racesVM.fetchRaces()
        
        let userPreferencesManager = UserPreferencesManager.shared
        userPreferencesManager.setLastUpdateDate()
        
        NotificationHelper.sendFetchNotification()
    }
}
