//
//  NewsView.swift
//  Stellar
//
//  Created by Elliot Knight on 04/08/2022.
//

import SwiftUI

struct NewsView: View {
	@EnvironmentObject public var news: NewsSpaceApi
	@State private var isNavigationIsActive: Bool = false
	var body: some View {
		NavigationView {
			ScrollView {
				ForEach(news.spaceNews, id: \.self) { new in
					NavigationLink(destination: Text(new.url)  , isActive: $isNavigationIsActive) {
						VStack {
						NewsAsyncImage(news: new)
						VStack(alignment: .leading, spacing: 10) {
							Text(new.title.trimmingCharacters(in: .whitespacesAndNewlines))
								.font(.headline)
								.foregroundColor(.primary)
							Text(new.url)
							//Link("DevTechie", destination: URL(string: "https://www.devtechie.com")!)
							Text(new.newsSite.rawValue)
								.foregroundColor(.secondary)
							Text(new.summary.trimmingCharacters(in: .whitespacesAndNewlines))
								.lineLimit(2)
								.foregroundColor(.secondary)
						}.multilineTextAlignment(.leading)
						.padding(5)
						.padding(.bottom)
					}

					.background(.regularMaterial)
					.cornerRadius(10)
					.shadow(radius: 10)
					.padding([.horizontal, .vertical])
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
