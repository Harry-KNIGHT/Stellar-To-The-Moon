//
//  StellarWidget.swift
//  StellarWidget
//
//  Created by Elliot Knight on 30/08/2022.
//

import WidgetKit
import SwiftUI
import StellarMoonKit


struct Provider: TimelineProvider {
	func placeholder(in context: Context) -> ArticleEntry {
		ArticleEntry(date: Date(), article: .astronomySample)
	}

	func getSnapshot(in context: Context, completion: @escaping (ArticleEntry) -> ()) {
		let entry = ArticleEntry(date: Date(), article: .astronomySample)
		completion(entry)
	}

	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		var entries: [ArticleEntry] = []

		// Generate a timeline consisting of five entries an hour apart, starting from the current date.
		let currentDate = Date()
		for hourOffset in 0 ..< 5 {
			let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
			let entry = ArticleEntry(date: entryDate, article: .astronomySample)
			entries.append(entry)
		}

		let timeline = Timeline(entries: entries, policy: .atEnd)
		completion(timeline)

	}
}

struct ArticleEntry: TimelineEntry {
	var date: Date
	var article: NasaAstronomyResponse
}

struct StellarWidgetEntryView : View {
	var entry: Provider.Entry


	var body: some View {
		ZStack {
			AsyncImage(url: URL(string: entry.article.url)) { image in
				image
					.resizable()
					.scaledToFill()
			} placeholder: {
				ProgressView()
			}
			Text(entry.article.title)
		}
	}
}

@main
struct StellarWidget: Widget {
	let kind: String = "StellarWidget"

	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			StellarWidgetEntryView(entry: entry)
		}
		.configurationDisplayName("Stellar Image Widget")
		.description("New image in widget each day 🚀")
	}
}

struct StellarWidget_Previews: PreviewProvider {
	static var previews: some View {
		StellarWidgetEntryView(entry: ArticleEntry(date: Date(), article: .astronomySample))
			.previewContext(WidgetPreviewContext(family: .systemSmall))
	}
}
