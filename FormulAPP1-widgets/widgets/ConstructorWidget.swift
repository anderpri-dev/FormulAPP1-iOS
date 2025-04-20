//
//  Provider.swift
//  FormulAPP1
//
//  Created by ANDER on 5/5/25.
//


import WidgetKit
import SwiftUI

struct ProviderConstructor: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntryConstructor {
        SimpleEntryConstructor(date: Date(), standingConstructor: sampleStandingConstructor)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntryConstructor) -> Void) {
        let entry = SimpleEntryConstructor(date: Date(), standingConstructor: sampleStandingConstructor)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntryConstructor>) -> Void) {
        fetchEntry { entry in
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
    
    func fetchEntry(completion: @escaping (SimpleEntryConstructor) -> Void) {
        DispatchQueue.global().async {
            let favouriteId = UserPreferencesManager.shared.getFavouriteConstructor()
            let constructor = favouriteId.flatMap { WidgetViewModel().getConstructorStandingById(constructorId: $0) }
            let entry = SimpleEntryConstructor(date: Date(), standingConstructor: constructor)
            completion(entry)
        }
    }
}

struct SimpleEntryConstructor: TimelineEntry {
    let date: Date
    let standingConstructor: ConstructorStandingDomainModel?
}

struct ConstructorWidgetEntryView: View {
    var entry: ProviderConstructor.Entry

    var body: some View {
        guard let standingConstructor = entry.standingConstructor else {
            return AnyView(NoFavouriteWidget(isDriver: false))
        }
        return AnyView(ConstructorCardWidgetView(standing: standingConstructor))
    }
}

struct ConstructorWidget: Widget {
    let kind: String = "ConstructorWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ProviderConstructor()) { entry in
            ConstructorWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(LocalizedStringManager.shared.localizedString("widget.ctr_title"))
        .description(LocalizedStringManager.shared.localizedString("widget.ctr_desc"))
        .supportedFamilies([.systemMedium])
    }
}
 
#Preview(as: .systemMedium) {
    ConstructorWidget()
} timeline: {
    SimpleEntryConstructor(date: .now, standingConstructor: sampleStandingConstructor)
}
