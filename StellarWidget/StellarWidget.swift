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

	func getSnapshot(in context: Context, completion: @escaping (ArticleEntry) -> Void) {
		let entry = ArticleEntry(date: Date(), article: .astronomySample)
		completion(entry)
	}

	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
		Task {
			do {
			let article = try await AstronomyApi.nasaApi()
				let entry = ArticleEntry(date: .now, article: article)

				let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15 * 60)))

				completion(timeline)
			} catch {
				print(error)
			}
		}
	}
}

struct ArticleEntry: TimelineEntry {
	var date: Date
	var article: NasaAstronomyResponse
}

struct StellarWidgetEntryView: View {
	var entry: Provider.Entry
	let applePark = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Apple_park_cupertino_2019.jpg/2560px-Apple_park_cupertino_2019.jpg"

	var body: some View {
		ZStack {
			if entry.article.mediaType == "image" {
				if let url = entry.article.url, let imageData = try? Data(contentsOf: URL(string: url) ?? URL(string: applePark)!), let uiImage = UIImage(data: imageData) {
					Image(uiImage: uiImage)
						.resizable()
						.aspectRatio(contentMode: .fill)
				} else {
					Image("SamerDaboulAstronomy")
						.resizable()
						.aspectRatio(contentMode: .fill)
				}
			} else {
				Image("AstronomyImageIfVideoMediaType")
					.resizable()
					.aspectRatio(contentMode: .fill)
			}
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
		.description("New astronomical image in widget each day 🚀")
		.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
	}
}

struct StellarWidget_Previews: PreviewProvider {
	static var previews: some View {
		StellarWidgetEntryView(entry: ArticleEntry(date: Date(), article: .astronomySample))
			.previewContext(WidgetPreviewContext(family: .systemSmall))
			.previewLayout(.sizeThatFits)
	}
}
