//
//  FetchArticlesViewModel.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
@preconcurrency import StellarMoonKit

class FetchArticlesViewModel: ObservableObject {
	@Published var articles: [Article]

	init() {
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

	@MainActor func getArticles() {
		Task {
			do {
				let fetchedArticles = try await FetchArticlesApi.fetchArticles()
				let filteredArticles = fetchedArticles.filter { $0.mediaType == .image }
				articles = filteredArticles
				save()
			} catch {
				print("Error \(error.localizedDescription)")
			}
		}
	}
}
