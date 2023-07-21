//
//  FetchArticlesViewModel.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
// TODO: Use business entity for remove this import
import Api
import Domain

class FetchArticlesViewModel: ObservableObject {
	@Published var articles: [Article]
	private let repository: ArticlesRepository

	init(repository: ArticlesRepository) {
		self.repository = repository

		if let data = UserDefaults.standard.data(forKey: "SavedData") {
			if let decoded = try? JSONDecoder().decode([Article].self, from: data) {
				articles = decoded
				return
			}
		}
		// No Saved data
		articles = []
	}

	private func save() {
		if let encoded = try? JSONEncoder().encode(articles) {
			UserDefaults.standard.set(encoded, forKey: "SavedData")
		}
	}

	@MainActor
	func getArticles() async {
		do {
			self.articles = try await repository.getArticles()
		} catch {
			self.articles = []
		}

	}

	private func filterFetchedArticles(fetchedArticles: [Article]) {
		let filteredArticles = fetchedArticles.filter { $0.mediaType == .image }
		articles = filteredArticles
		save()
	}
}
