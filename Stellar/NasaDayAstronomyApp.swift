//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import OneSignal

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyVM = DownloadImageViewModel()
	@StateObject var articlesVM = FetchArticlesViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var searchDateArticleVM = SearchDateArticleViewModel()

	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

	@StateObject var deeplinkManager = DeepLinkManager()

	var body: some Scene {
		WindowGroup {
			NavigationView {
				MainScreen()
					.environmentObject(astronomyVM)
					.environmentObject(articlesVM)
					.environmentObject(favoriteVM)
					.environmentObject(searchDateArticleVM)
					.environmentObject(deeplinkManager)
					.sheet(item: $deeplinkManager.selectedRoute) { route in
						switch route {
						case .articleDetail(let article):
							ArticleDetailView(article: article)
								.environmentObject(astronomyVM)
								.environmentObject(articlesVM)
								.environmentObject(favoriteVM)
								.environmentObject(searchDateArticleVM)
								.environmentObject(deeplinkManager)
						}
					}
					.navigationTitle("navigationTitle_homepage")
					.navigationBarTitleDisplayMode(.inline)
			}
			.navigationViewStyle(StackNavigationViewStyle())
			.onOpenURL { url in
				deeplinkManager.handleUrl(url)
			}
		}
	}
}

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		// Remove this method to stop OneSignal Debugging
		OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

		OneSignal.initWithLaunchOptions(launchOptions)
		OneSignal.setAppId("6b80052a-a147-45bb-bfc3-de331f2c33f6")

		OneSignal.promptForPushNotifications(userResponse: { accepted in
			print("User accepted notification: \(accepted)")
		})
		// Set your customer userId
		// OneSignal.setExternalUserId("userId")
		return true
	}
}
