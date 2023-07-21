//
//  MainScreen.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import Domain
import Api

struct MainScreen: View {
	@EnvironmentObject private var articlesVM: FetchArticlesViewModel
	@State private var showFavoritesSheet = false

	var body: some View {
		NavigationView {
			ArticlesGridView(showFavoritesSheet: $showFavoritesSheet)
		}
		.navigationViewStyle(StackNavigationViewStyle())

		.navigationTitle("navigationTitle_homepage")
		.navigationBarTitleDisplayMode(.inline)
		.task {
			await articlesVM.getArticles()
		}
	}
}

struct AstronomyImageGrid_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
			.environmentObject(FetchArticlesViewModel(repository: ArticlesRepositoryDefault(api: ArticlesService())))
			.environmentObject(FavoriteViewModel())
			.environmentObject(DownloadImageViewModel())
	}
}
