//
//  FavoriteViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import Foundation

class FavoriteViewModel: ObservableObject {
	@Published public var favoriteAstronomyArticles: [NasaAstronomyResponse]

	init() {
		if let data = UserDefaults.standard.data(forKey: "SavedData") {
			if let decoded = try? JSONDecoder().decode([NasaAstronomyResponse].self, from: data) {
				favoriteAstronomyArticles = decoded
				return
			}
		}
		// No Saved data
		favoriteAstronomyArticles = []
	}

	func save() {
		if let encoded = try? JSONEncoder().encode(favoriteAstronomyArticles) {
			UserDefaults.standard.set(encoded, forKey: "SavedData")
		}
	}

	func addToFavorite(article: NasaAstronomyResponse) {
		self.favoriteAstronomyArticles.append(article)
	}

	func deletFavorite(at offsets: IndexSet) {
		favoriteAstronomyArticles.remove(atOffsets: offsets)
	}

	func deletSelectedFavorite(article: NasaAstronomyResponse) {
		self.favoriteAstronomyArticles.removeAll { $0.date == article.date }
	}

	func moveFavorite(from index: IndexSet, to offset: Int) {
		self.favoriteAstronomyArticles.move(fromOffsets: index, toOffset: offset)
	}

	func addOrDeletFavorite(article: NasaAstronomyResponse) {
		if self.favoriteAstronomyArticles.contains(article) {
			deletSelectedFavorite(article: article)
			save()
		}else {
			addToFavorite(article: article)
			save()
		}
	}
}
