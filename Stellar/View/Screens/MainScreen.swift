//
//  MainScreen.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI

struct MainScreen: View {
	@EnvironmentObject private var articleVm: FetchArticlesViewModel
	@State private var showFavoritesSheet = false
	@State private var showLoadingIndicator = true
	@State private var showBirthdayPicker = false

	var body: some View {
		NavigationView {
			VStack {
				switch articleVm.articles.isEmpty {
				case true:
					LoadingView()
				default:
					ArticlesGridView(showFavoritesSheet: $showFavoritesSheet, showBirthdayPicker: $showBirthdayPicker)
				}
			}
			.navigationTitle("navigationTitle_homepage")
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				articleVm.getArticles()
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct AstronomyImageGrid_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
			.environmentObject(FetchArticlesViewModel())
			.environmentObject(FavoriteViewModel())
			.environmentObject(SearchDateArticleViewModel())
			.environmentObject(DownloadImageViewModel())
	}
}
