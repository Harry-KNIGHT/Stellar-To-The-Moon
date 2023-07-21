//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import Api
import Domain

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyVM = DownloadImageViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var articlesVM = FetchArticlesViewModel(
		repository: ArticlesRepositoryDefault(api: ArticlesService())
	)

	var body: some Scene {
		WindowGroup {
				MainScreen()
					.environmentObject(astronomyVM)
					.environmentObject(articlesVM)
					.environmentObject(favoriteVM)
		}
	}
}
