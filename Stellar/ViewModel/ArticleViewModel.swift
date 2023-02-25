//
//  ArticleViewModel.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import StellarMoonKit

class ArticleViewModel: ObservableObject {
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

	@MainActor func getArticles(from hundredDayBefore: Int64 = Date().millisecondsSince1970, to today: Date) {
		Task {
			do {
				articles = try await FetchArticlesApi.fetchAstronomiesObject(from: hundredDayBefore, to: today)
				save()
			} catch {
				print("Error \(error.localizedDescription)")
			}
		}
	}
}
