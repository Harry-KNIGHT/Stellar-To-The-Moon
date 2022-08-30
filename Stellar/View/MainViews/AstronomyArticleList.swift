//
//  AstronomyList.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import ActivityIndicatorView
import RefreshableScrollView

struct AstronomyArticleList: View {
	@EnvironmentObject public var articleApi: AstronomiesArticleViewModel
	@State private var showSheet = false
	@State private var showLoadingIndicator = true

	var body: some View {
		NavigationView {
			VStack {
				if articleApi.allAstronomies.isEmpty {
					LoadingView()
				}else {
					RefreshableScrollView {
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
						}
						.padding([.horizontal, .top])
						.navigationTitle("Stellar")
						.navigationBarTitleDisplayMode(.inline)
					}
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
					.refreshable {
						do {
							try await articleApi.getAstronomiesArticles(to: Date.now)
						}catch {
							print("Error while refresh: \(error.localizedDescription)")
						}
					}
				}
			}
		}
		.task {
			do {
				try await articleApi.getAstronomiesArticles(to: Date.now)
			} catch {
				print("Error: \(error.localizedDescription)")
			}
		}
	}
}

struct AstronomyArticleList_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyArticleList()
			.environmentObject(AstronomiesArticleViewModel())
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

// Tableau d'articles sur l'astronomie

// Récupère ce tableau

// Affiche en liste

// List à detail -> Chargement qui casse les couilles
