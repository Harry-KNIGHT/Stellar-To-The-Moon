//
//  DeeplinkManager.swift
//  Stellar
//
//  Created by Elliot Knight on 10/04/2023.
//

import Foundation
import StellarMoonKit

final class DeepLinkManager: ObservableObject {

	private var articlesVM = ArticleViewModel()
	private let fetchDeeplinkArticleViewModel = FetchDeeplinkArticleViewModel()
	
	@Published var selectedArticleID: String?
	@Published var selectedRoute: AppRoute? = nil

	func handleUrl(_ url: URL) {
		// Analyse de l'URL et de la définition de la route sélectionnée.
		// Exemple: stellar://article?date=2023-04-01
		guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false),
			  let host = components.host else {
			return
		}

		switch host {
		case "article":
			if let id = components.queryItems?.first(where: { $0.name == "date" })?.value {
				// Récupérer l'article correspondant à l'ID, puis définir la route sélectionnée.
				if let article = getArticleLocalyOrRemotely(id) {
					selectedRoute = .articleDetail(article)
				}
			}
		default:
			break
		}
	}

	func removeSelectedRoute() {
		self.selectedRoute = nil
	}

	public enum AppRoute: Identifiable {
		case articleDetail(Article)

		var id: String {
			switch self {
			case .articleDetail(let article):
				return article.title
			}
		}
	}

	private func getArticleLocaly(_ date: String) -> Article? {
		return articlesVM.articles.first { $0.date == date }
	}

	private func getArticleRemotely(_ date: String) -> Article? {
		fetchDeeplinkArticleViewModel.fetchRemoteDeeplinkArticle(date)

		guard let remoteArticle = fetchDeeplinkArticleViewModel.deeplinkArticle else { return nil }
		return remoteArticle
	}

	func getArticleLocalyOrRemotely(_ date: String) -> Article? {

		if articlesVM.articles.map({ $0.date }).contains(date) {
			return getArticleLocaly(date)
		}
		return getArticleRemotely(date)
	}
}
