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

	var body: some View {
		NavigationView {
			ArticlesGridView(showFavoritesSheet: $showFavoritesSheet)
		}
		.navigationViewStyle(StackNavigationViewStyle())

		.navigationTitle("navigationTitle_homepage")
		.navigationBarTitleDisplayMode(.inline)
		.onAppear {
			articleVm.getArticles()
		}
	}
}

struct AstronomyImageGrid_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
			.environmentObject(FetchArticlesViewModel())
			.environmentObject(FavoriteViewModel())
			.environmentObject(DownloadImageViewModel())
	}
}
