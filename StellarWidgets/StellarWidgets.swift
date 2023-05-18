//
//  StellarWidgets.swift
//  StellarWidgets
//
//  Created by Elliot Knight on 18/05/2023.
//

import WidgetKit
import SwiftUI
import StellarMoonKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date(), article: .imageArticleSample)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
		let entry = SimpleEntry(date: Date(), article: .imageArticleSample)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		Task {
			do {
				let articlesArray = try await FetchArticlesApi.fetchArticles()
				let filteredArticles = articlesArray.filter { $0.mediaType == .image }
				let todaysArticle = filteredArticles.randomElement()
				let entry = SimpleEntry(date: Date(), article: todaysArticle ?? articlesArray[0])
				let timeline = Timeline(entries: [entry], policy: .atEnd)
				completion(timeline)
			} catch {
				throw ApiError.badHttpResponse
			}
		 }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
	let article: Article
}

struct StellarWidgetsEntryView : View {
    var entry: Provider.Entry

	var body: some View {
		Link(destination: URL(string: "stellar://article?date=\(entry.article.date)")!) {
			NetworkImage(url: URL(string: entry.article.mediaUrl))
				.widgetURL(URL(string: "stellar://article?date=\(entry.article.date)")!)
		}
	}
}

struct StellarWidgets: Widget {
    let kind: String = "StellarWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StellarWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Stellar Widget")
        .description("Astronomical images.")
    }
}

struct StellarWidgets_Previews: PreviewProvider {
    static var previews: some View {
		StellarWidgetsEntryView(entry: SimpleEntry(date: Date(), article: .imageArticleSample))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
