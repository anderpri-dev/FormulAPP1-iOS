//
//  UserPreferencesManager.swift
//  FormulAPP1
//
//  Created by ANDER on 9/5/25.
//

import Foundation
import WidgetKit

class UserPreferencesManager {
    
    static let shared = UserPreferencesManager()
    static let sharedDefaults = UserDefaults(suiteName: "group.es.upsa.mimo.FormulAPP1")
    private init() {}
    
    func setFavouriteDriver(driverId: String) {
        UserPreferencesManager.sharedDefaults?.set(driverId, forKey: "favouriteDriver")
        WidgetCenter.shared.reloadAllTimelines()
        print("Driver ID set to: \(driverId)")
    }
    
    func getFavouriteDriver() -> String? {
        let driverId: String? = UserPreferencesManager.sharedDefaults?.string(forKey: "favouriteDriver")
        //print("Driver ID retrieved: \(String(describing: driverId))")
        return driverId
    }
    
    func removeFavouriteDriver() {
        UserPreferencesManager.sharedDefaults?.removeObject(forKey: "favouriteDriver")
        WidgetCenter.shared.reloadAllTimelines()
        print("Driver ID removed")
    }
    
    func setFavouriteConstructor(constructorId: String) {
        UserPreferencesManager.sharedDefaults?.set(constructorId, forKey: "favouriteConstructor")
        WidgetCenter.shared.reloadAllTimelines()
        print("Constructor ID set to: \(constructorId)")
    }
    
    func getFavouriteConstructor() -> String? {
        let constructorId: String? = UserPreferencesManager.sharedDefaults?.string(forKey: "favouriteConstructor")
        //print("Constructor ID retrieved: \(String(describing: constructorId))")
        return constructorId
    }
    
    func removeFavouriteConstructor() {
        UserPreferencesManager.sharedDefaults?.removeObject(forKey: "favouriteConstructor")
        WidgetCenter.shared.reloadAllTimelines()
        print("Constructor ID removed")
    }
    
    func setLastUpdateDate() {
        let date = Date()
        UserPreferencesManager.sharedDefaults?.set(date, forKey: "lastUpdateDate")
        print("Last update date set to: \(date)")
    }
    
    func getLastUpdateDate() -> Date? {
        let date: Date? = UserPreferencesManager.sharedDefaults?.object(forKey: "lastUpdateDate") as? Date
        //print("Last update date retrieved: \(String(describing: date))")
        return date
    }
    
    func setLanguage(_ languageCode: String) {
        UserPreferencesManager.sharedDefaults?.set(languageCode, forKey: "selectedLanguage")
    }

    func getLanguage() -> String? {
        let languageCode: String? = UserPreferencesManager.sharedDefaults?.string(forKey: "selectedLanguage")
        return languageCode
    }
    
    func clearPreferences() {
        UserPreferencesManager.sharedDefaults?.removeObject(forKey: "favouriteDriver")
        UserPreferencesManager.sharedDefaults?.removeObject(forKey: "favouriteConstructor")
        UserPreferencesManager.sharedDefaults?.removeObject(forKey: "lastUpdateDate")
        print("All user preferences cleared")
    }
}
