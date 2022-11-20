//
//  AstronomyImageGrid.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import ActivityIndicatorView
import RefreshableScrollView

struct AstronomyImageGrid: View {
	@EnvironmentObject public var articleApi: AstronomiesArticleViewModel
	@State private var showSheet = false
	@State private var showLoadingIndicator = true

	private let columnsiPhone = [
		GridItem(.flexible(), spacing: 0),
		GridItem(.flexible(), spacing: 0)
	]
	private let columnsiPad = [
		GridItem(.flexible(), spacing: 0),
	]
	
	private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

	var body: some View {
		NavigationView {
			VStack {
				if articleApi.allAstronomies.isEmpty {
					LoadingView()
				} else {
					ScrollView {
						LazyVGrid(columns: idiom == .phone ? columnsiPhone : columnsiPad, alignment: .center, spacing: 0) {
							ForEach(articleApi.allAstronomies.reversed(), id: \.date) { article in
								NavigationLink(destination: AstronomyDetailView(article: article)) {
									if article.mediaType == .image {
										AstronomyImageListCell(article: article)
									} else {
										VideoPlaceHolderCell(article: article)
									}
								}
							}
						}
					}
					.toolbar {
						ToolbarItem(placement: .navigationBarTrailing) {
							if !articleApi.allAstronomies.isEmpty {
								ShowFavSheetButtonCell(showSheet: $showSheet)
							}
						}
					}
					.refreshable {
						do {
							try await articleApi.getAstronomiesArticles(to: Date.now)
						} catch {
							print("Error while refresh: \(error.localizedDescription)")
						}
					}
				}
			}
			.navigationTitle("Stellar")
			.navigationBarTitleDisplayMode(.inline)
			.task {
				do {
					try await articleApi.getAstronomiesArticles(to: Date.now)
				} catch {
					print("Error: \(error.localizedDescription)")
				}
			}
		}
	}
}

struct AstronomyImageGrid_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyImageGrid()
			.environmentObject(AstronomiesArticleViewModel())
	}
}
