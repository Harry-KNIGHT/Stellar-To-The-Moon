//
//  StellarWidgetImage.swift
//  StellarWidgetImage
//
//  Created by Elliot Knight on 17/12/2022.
//

import WidgetKit
import SwiftUI
import StellarMoonKit

struct Provider: TimelineProvider {
	func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date(), article: .astronomySample)
	}

	func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
		let entry = SimpleEntry(date: Date(), article: .astronomySample)
		completion(entry)
	}

	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		Task {
			do {
				let article = try await AstronomyApi.nasaApi()
				let entry = SimpleEntry(date: Date(), article: article)

				let timeline = Timeline(entries: [entry], policy: .after(.now.addingTimeInterval(10)))
				completion(timeline)
			} catch {
				throw error
			}
		}
	}
}

struct SimpleEntry: TimelineEntry {
	let date: Date
	let article: AstronomyArticleModel
}

struct StellarWidgetImageEntryView : View {
	var entry: Provider.Entry
	@Environment(\.widgetFamily) var widgetFamilies
	var body: some View {
		switch widgetFamilies {
		case .systemSmall:
			ImageTextWidgetExtracted(entry: entry, font: .caption, backgroundLinearPadding: 25)
		case .systemMedium:
			ImageTextWidgetExtracted(entry: entry, font: .headline, backgroundLinearPadding: 25)
		case .systemLarge:
			ImageTextWidgetExtracted(entry: entry, font: .title2, backgroundLinearPadding: 35)
		default:
			Text("Something went wrong.")
		}
	}
}

struct StellarWidgetImage: Widget {
	let kind: String = "StellarWidgetImage"

	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			StellarWidgetImageEntryView(entry: entry)
		}
		.configurationDisplayName("Astronomical image widget")
		.description("New astronomical image each day.")
		.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
	}
}

struct StellarWidgetImage_Previews: PreviewProvider {
	static var previews: some View {
		StellarWidgetImageEntryView(entry: SimpleEntry(date: Date(), article: .astronomySample))
			.previewContext(WidgetPreviewContext(family: .systemSmall))
	}
}


struct ImageTextWidgetExtracted: View {
	var entry: Provider.Entry
	var font: Font
	var backgroundLinearPadding: CGFloat

	var body: some View {
		ZStack(alignment: .bottomLeading) {
			NetworkImage(url: URL(string: entry.article.url))
			HStack {
				Text(entry.article.title)
					.font(font)
					.fontDesign(.rounded)
					.lineLimit(1)
					.padding(.bottom)
					.padding(.horizontal, 10)
					.foregroundColor(.white)
				Spacer()
			}
			.padding(.top, backgroundLinearPadding)
			.background(LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom))
		}
	}
}
