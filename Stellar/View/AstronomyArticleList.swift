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
	@State private var showSheet = false
	@State private var showLoadingIndicator = true
	var body: some View {
		NavigationView {
			VStack {
				if articleApi.allAstronomies.isEmpty {
					LoadingView()
				}else {
					List {
						ForEach(articleApi.allAstronomies.reversed(), id: \.date) { article in
							NavigationLink(destination: AstronomyDetailView(article: article)) {
								ListRowCell(title: article.title, date: article.date, explanation: article.explanation)
							}
						}
					}
				}
			}

			.navigationTitle(articleApi.allAstronomies.isEmpty ? "" : "Stellar")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
						Button(action: {
							showSheet.toggle()

						}, label: {
							Label("Add article to favorite", systemImage: articleApi.allAstronomies.isEmpty ? "" : "star.fill")
								.font(.title3)
								.foregroundColor(.primary)
						}).sheet(isPresented: $showSheet) {
							FavoritesArticleList()
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
	}
}

struct AstronomyArticleList_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyArticleList()
			.environmentObject(AstronomiesArticleApi())
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
			Text(date)
				.font(.callout)
				.foregroundStyle(.secondary)
			Text(explanation)
				.font(.body)
				.foregroundColor(.secondary)
				.lineLimit(2)
		}
	}
}
