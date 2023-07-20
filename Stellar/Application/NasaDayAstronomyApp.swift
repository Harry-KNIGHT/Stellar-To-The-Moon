//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyVM = DownloadImageViewModel()
	@StateObject var articlesVM = FetchArticlesViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var searchDateArticleVM = SearchDateArticleViewModel()

	var body: some Scene {
		WindowGroup {
				MainScreen()
					.environmentObject(astronomyVM)
					.environmentObject(articlesVM)
					.environmentObject(favoriteVM)
					.environmentObject(searchDateArticleVM)
		}
	}
}
