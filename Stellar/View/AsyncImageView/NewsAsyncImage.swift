//
//  NewsAsyncImage.swift
//  Stellar
//
//  Created by Elliot Knight on 04/08/2022.
//

import SwiftUI

struct NewsAsyncImage: View {
	let news: NewsResponseElement
    var body: some View {
		AsyncImage(url: URL(string: news.imageURL)) { image in
			image
				.resizable()
				.scaledToFit()
				.frame(maxWidth: .infinity, maxHeight: .infinity)
		}placeholder: {
			ZStack(alignment: .center) {
			RoundedRectangle(cornerRadius: 10)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.foregroundStyle(.secondary)
				Text("Stellar To The 🌝")
					.padding(.vertical, 15)
			}
		}
    }
}

struct NewsAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
		NewsAsyncImage(news: NewsResponseElement(id: 15992, title: "Geospatial analysis provider Descartes Labs sold to private equity firm", url: "https://spacenews.com/wp-content/uploads/2018/09/rsz_rgb_sar_ships.jpg", imageURL: "https://spacenews.com/wp-content/uploads/2018/09/rsz_rgb_sar_ships.jpg", newsSite: .spaceNews, summary: "Private equity firm Antarctica Capital has acquired geospatial analytics provider Descartes Labs to support its growing space-based data portfolio.", publishedAt: "2022-08-04T13:01:05.000Z", updatedAt: "2022-08-04T13:01:05.572Z", featured: false, launches: [], events: []))
    }
}
