//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyVM = ArticleDetailViewModel()
	@StateObject var articlesVM = ArticleViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var searchDateArticleVM = SearchDateArticleViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(astronomyVM)
				.environmentObject(articlesVM)
				.environmentObject(favoriteVM)
				.environmentObject(searchDateArticleVM)
        }
    }
}
