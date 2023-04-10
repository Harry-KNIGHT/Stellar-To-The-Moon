//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import OneSignal
import StellarMoonKit

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyVM = DownloadImageViewModel()
	@StateObject var articlesVM = FetchArticlesViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var searchDateArticleVM = SearchDateArticleViewModel()

	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@State private var selectedRoute: AppRoute? = nil

	var body: some Scene {
		WindowGroup {
			NavigationView {
				MainScreen()
					.environmentObject(astronomyVM)
					.environmentObject(articlesVM)
					.environmentObject(favoriteVM)
					.environmentObject(searchDateArticleVM)
					.sheet(item: $selectedRoute) { route in
						switch route {
						case .articleDetail(let article):
							ArticleDetailView(article: article, isInFavoriteDetail: false)
								.environmentObject(astronomyVM)
								.environmentObject(articlesVM)
								.environmentObject(favoriteVM)
								.environmentObject(searchDateArticleVM)
						}
					}
					.navigationTitle("navigationTitle_homepage")
					.navigationBarTitleDisplayMode(.inline)
			}
			.onOpenURL { url in
				handleUrl(url)
			}
		}
	}

	func getArticleByDate(_ date: String) -> Article? {
		let articles: [Article] = articlesVM.articles

		return  articles.first { $0.date == date }

	}

	func handleUrl(_ url: URL) {
		// Analyse de l'URL et de la définition de la route sélectionnée.
		// Exemple: myapp://articleDetail?id=123
		guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false),
			  let host = components.host else {
			return
		}

		// stellar://article?date=2023-04-01
		switch host {
		case "article":
			if let id = components.queryItems?.first(where: { $0.name == "date" })?.value {
				// Récupérer l'article correspondant à l'ID, puis définir la route sélectionnée.
				// Remplacez `getArticleById(_:)` par la méthode appropriée pour récupérer un article en fonction de l'ID.
				if let article = getArticleByDate(id) {
					selectedRoute = .articleDetail(article)
				}
			}
		default:
			break
		}
	}
}

enum AppRoute: Identifiable {
	case articleDetail(Article)

	var id: String {
		switch self {
		case .articleDetail(let article):
			return article.title
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
