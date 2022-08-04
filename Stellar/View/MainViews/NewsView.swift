//
//  NewsView.swift
//  Stellar
//
//  Created by Elliot Knight on 04/08/2022.
//

import SwiftUI

struct NewsView: View {
	@EnvironmentObject public var news: NewsSpaceApi
    var body: some View {
		NavigationView {
			ScrollView {
				ForEach(news.spaceNews, id: \.self) { new in
					VStack(alignment: .leading, spacing: 5) {
						NewsAsyncImage(news: new)
					Text(new.title)
					Text(new.publishedAt)
						.foregroundColor(.secondary)
					Text(new.summary)
						.lineLimit(2)
					}

				}
			}.task {
				do {
					try await news.fetchSpaceNews()
				} catch {
					print("Error in view fetching space news: \(error.localizedDescription)")
				}
			}.navigationTitle("News")
		}
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
			.environmentObject(NewsSpaceApi())
    }

}
