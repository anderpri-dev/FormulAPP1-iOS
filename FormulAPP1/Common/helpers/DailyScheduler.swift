//
//  DailyScheduler.swift
//  FormulAPP1
//
//  Created by ANDER on 6/5/25.
//


import Foundation
import Combine

class DailyScheduler {
    private var cancellables = Set<AnyCancellable>()
    
    func scheduleDaily(time: (hour: Int, minutes: Int, seconds: Int), action: @escaping () -> Void) {
        // Ejecutar inmediatamente
        action()
        storeLastUpdateDate()
        
        // Programar para la siguiente medianoche
        let now = Date()
        var calendar = Calendar.current
        calendar.timeZone = .current

        var nextRun = calendar.date(bySettingHour: time.hour, minute: time.minutes, second: time.seconds, of: now)!
        if nextRun <= now {
            nextRun = calendar.date(byAdding: .day, value: 1, to: nextRun)!
        }

        // Calculamos cuánto falta para la próxima ejecución
        let delay = nextRun.timeIntervalSince(now)
        
        // Programamos la tarea para que se ejecute en el momento adecuado
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            action()
            self?.storeLastUpdateDate()
            self?.startRepeatingEveryDay(action: action)
            print("Scheduler started for daily updates.")
        }
    }
    
    func schedule(every interval: TimeInterval = 30, action: @escaping () -> Void) {
        action() // Run immediately
        Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                action()
                self.storeLastUpdateDate()
            }
            .store(in: &cancellables)
    }

    private func startRepeatingEveryDay(action: @escaping () -> Void) {
        Timer
            .publish(every: 86400, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                action()
                self.storeLastUpdateDate()
            }
            .store(in: &cancellables)
    }
    
    private func storeLastUpdateDate() {
        UserDefaults.standard.set(Date(), forKey: "lastUpdateDate")
    }
}
