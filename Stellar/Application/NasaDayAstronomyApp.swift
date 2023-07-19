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

	@StateObject var deeplinkManager = DeepLinkManager()
	@StateObject private var locationManager = LocationManager()

	var body: some Scene {
		WindowGroup {
			NavigationView {
				MainScreen()
					.environmentObject(astronomyVM)
					.environmentObject(articlesVM)
					.environmentObject(favoriteVM)
					.environmentObject(searchDateArticleVM)
					.environmentObject(deeplinkManager)
					.environmentObject(locationManager)
					.sheet(item: $deeplinkManager.selectedRoute) { route in
						switch route {
						case .articleDetail(let article):
							ArticleDetailView(article: article)
								.environmentObject(astronomyVM)
								.environmentObject(articlesVM)
								.environmentObject(favoriteVM)
								.environmentObject(searchDateArticleVM)
								.environmentObject(deeplinkManager)
								.environmentObject(locationManager)
						}
					}
					.navigationTitle("navigationTitle_homepage")
					.navigationBarTitleDisplayMode(.inline)
			}
			.navigationViewStyle(StackNavigationViewStyle())
			.onOpenURL { url in
				deeplinkManager.handleUrl(url)
			}
			.onAppear {
				locationManager.askUserLocation()
			}
		}
	}
}
