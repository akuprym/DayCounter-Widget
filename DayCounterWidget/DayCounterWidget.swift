//
//  DayCounterWidget.swift
//  DayCounterWidget
//
//  Created by admin on 9.02.24.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), days: 0, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), days: 0, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let userDefaults = UserDefaults(suiteName: "group.com.daycounter.widgetcache")
        let days = userDefaults?.value(forKey: "days")
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .day, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), days: days as? Int ?? 0, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let days: Int
    let configuration: ConfigurationIntent
}

struct DayCounterWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("photo")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .foregroundColor(.red)
            }
        }
        
        Text("I've been sugar-free for \(entry.days) days")
        .font(Font.system(size: 24, weight: .bold, design: .rounded))    }
}

struct DayCounterWidget: Widget {
    let kind: String = "DayCounterWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DayCounterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("DayCounter Widget")
        .description("Displays the number of days from a chosen date.")
    }
}

struct DayCounterWidget_Previews: PreviewProvider {
    static var previews: some View {
        DayCounterWidgetEntryView(entry: SimpleEntry(date: Date(), days: 0, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
