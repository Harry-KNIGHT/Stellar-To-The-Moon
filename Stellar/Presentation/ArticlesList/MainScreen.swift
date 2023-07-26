//
//  MainScreen.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import StellarApi
import Domain

struct MainScreen: View {
	@StateObject private var getArticlesVm = FetchArticlesViewModel(
		repository: ArticleRepositoryDefault(api: ArticlesService()))
	@State private var showFavoritesSheet = false

	var body: some View {
		NavigationView {
			ArticlesGridView(showFavoritesSheet: $showFavoritesSheet)
		}
		.navigationViewStyle(StackNavigationViewStyle())

		.navigationTitle("navigationTitle_homepage")
		.navigationBarTitleDisplayMode(.inline)
//		.onAppear {
//			articleVm.getArticles()
//		}
	}
}

struct AstronomyImageGrid_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
			.environmentObject(FavoriteViewModel())
			.environmentObject(DownloadImageViewModel())
	}
}
