//
//  FetchArticlesViewModel.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import Domain

class FetchArticlesViewModel: ObservableObject {
	@Published var articles: [Article] = []
	private let repository: ArticleRepository


	init(repository: ArticleRepository) {
		self.repository = repository

		Task {
			await getArticles()
		}
	}
//	init() {
//		if let data = UserDefaults.standard.data(forKey: "SavedData") {
//			if let decoded = try? JSONDecoder().decode([Article].self, from: data) {
//				articles = decoded
//				return
//			}
//		}
//		// No Saved data
//		articles = []
//	}

	private func save() {
		if let encoded = try? JSONEncoder().encode(articles) {
			UserDefaults.standard.set(encoded, forKey: "SavedData")
		}
	}

	@MainActor func getArticles() async {
		Task {
			do {
				let fetchedArticles = try await repository.getArticles()
				articles = fetchedArticles
			} catch {
				print("Error \(error.localizedDescription)")
			}
		}
	}

//	private func filterFetchedArticles(fetchedArticles: [Article]) {
//		let filteredArticles = fetchedArticles.filter { $0.mediaType == .image }
//		articles = filteredArticles
//		save()
//	}
}
