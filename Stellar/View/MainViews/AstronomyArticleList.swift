//
//  AstronomyList.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import ActivityIndicatorView

struct AstronomyArticleList: View {
	@EnvironmentObject public var articleApi: AstronomiesArticleApi
	@EnvironmentObject public var newsApi: NewsSpaceApi
	@State private var showSheet = false
	@State private var showLoadingIndicator = true

	var body: some View {
		NavigationView {
			VStack {
				if articleApi.allAstronomies.isEmpty {
					LoadingView()
				}else {
					ScrollView {
						LazyVStack {
							ForEach(articleApi.allAstronomies.reversed(), id: \.date) { article in
								NavigationLink(destination: AstronomyDetailView(article: article)) {
									ZStack {
										RoundedRectangle(cornerRadius: 10)
											.frame(maxWidth: .infinity, maxHeight: .infinity)
											.foregroundStyle(.regularMaterial)

										VStack(alignment: .leading) {
											ListRowCell(title: article.title, date: article.date, explanation: article.explanation)
										}.padding()
									}
								}
							}
						}.padding([.horizontal, .top])

					}
				}
			}

			.navigationTitle(articleApi.allAstronomies.isEmpty ? "" : "Stellar")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					if !articleApi.allAstronomies.isEmpty {
						Button(action: {
							showSheet.toggle()

						}, label: {
							Label("Add article to favorite", systemImage: "star.fill")
								.font(.title3)
								.foregroundColor(.primary)
						})
						.sheet(isPresented: $showSheet) {
							FavoritesArticleList()
						}
					}
				}
			}
		}.refreshable {
			Task {
				articleApi.allAstronomies
			}
		}
		.task {
			await articleApi.fetchAstronomiesObject(to: Date.now)
		}
		
		.onAppear {
				Task {
					try await newsApi.fetchSpaceNews()
				}
		}
	}
}

struct AstronomyArticleList_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyArticleList()
			.environmentObject(AstronomiesArticleApi())
			.environmentObject(NewsSpaceApi())
	}
}

struct ListRowCell: View {
	var title: String
	var date: String
	var explanation: String
	var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			Text(title)
				.font(.headline)
				.foregroundColor(.primary)
			Text(date)
				.font(.callout)
				.foregroundColor(.secondary)
			Text(explanation.trimmingCharacters(in: .whitespacesAndNewlines))
				.font(.body)
				.foregroundColor(.secondary)
				.lineLimit(2)

		}	.multilineTextAlignment(.leading)
	}
}
