//
//  DeeplinkManager.swift
//  Stellar
//
//  Created by Elliot Knight on 15/05/2023.
//

import Foundation
import StellarMoonKit

final class DeepLinkManager: ObservableObject {

	private var articlesVM = FetchArticlesViewModel()

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
				if let article = getArticleLocaly(id) {
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
		guard articlesVM.articles.map({ $0.date }).contains(date) else { return nil }
		return articlesVM.articles.first { $0.date == date }
	}
}

