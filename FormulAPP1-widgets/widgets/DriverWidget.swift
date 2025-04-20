//
//  DriverWidget.swift
//  FormulAPP1
//
//  Created by ANDER on 5/5/25.
//

import WidgetKit
import SwiftUI

struct ProviderDriver: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntryDriver {
        SimpleEntryDriver(date: Date(), standingDriver: sampleStandingDriver)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntryDriver) -> Void) {
        let entry = SimpleEntryDriver(date: Date(), standingDriver: sampleStandingDriver)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntryDriver>) -> Void) {
        fetchEntry { entry in
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
    
    func fetchEntry(completion: @escaping (SimpleEntryDriver) -> Void) {
        DispatchQueue.global().async {
            let favouriteId = UserPreferencesManager.shared.getFavouriteDriver()
            let driver = favouriteId.flatMap { WidgetViewModel().getDriverStandingById(driverId: $0) }
            let entry = SimpleEntryDriver(date: Date(), standingDriver: driver)
            completion(entry)
        }
    }
}

struct SimpleEntryDriver: TimelineEntry {
    let date: Date
    let standingDriver: DriverStandingDomainModel?
}

struct DriverWidgetEntryView: View {
    var entry: ProviderDriver.Entry

    var body: some View {
        guard let standingDriver = entry.standingDriver else {
            return AnyView(NoFavouriteWidget(isDriver: true))
        }
        return AnyView(DriverCardWidgetView(standing: standingDriver))
    }
}

struct DriverWidget: Widget {
    let kind: String = "DriverWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ProviderDriver()) { entry in
            DriverWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(LocalizedStringManager.shared.localizedString("widget.drv_title"))
        .description(LocalizedStringManager.shared.localizedString("widget.drv_desc"))
        .supportedFamilies([.systemMedium])
    }
}
 
#Preview(as: .systemMedium) {
    DriverWidget()
} timeline: {
    SimpleEntryDriver(date: .now, standingDriver: sampleStandingDriver)
}

#Preview(as: .systemMedium) {
    DriverWidget()
} timeline: {
    let driverId = "norris"
    let driver = WidgetViewModel().getDriverStandingById(driverId: driverId)
    SimpleEntryDriver(date: .now, standingDriver: driver ?? sampleStandingDriver)
}

