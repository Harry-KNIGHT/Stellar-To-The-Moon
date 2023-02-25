//
//  FavoriteViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import Foundation
import StellarMoonKit

class FavoriteViewModel: ObservableObject {
	@Published var favoriteAstronomyArticles: [Article]

	init() {
		if let data = UserDefaults.standard.data(forKey: "SavedFavoritesData") {
			if let decoded = try? JSONDecoder().decode([Article].self, from: data) {
				favoriteAstronomyArticles = decoded
				return
			}
		}
		// No Saved data
		favoriteAstronomyArticles = []
	}

	private func save() {
		if let encoded = try? JSONEncoder().encode(favoriteAstronomyArticles) {
			UserDefaults.standard.set(encoded, forKey: "SavedFavoritesData")
		}
	}

	/// Add article to favorite
	/// - Parameter article: Article is from NasaAstronomy model
	private func addToFavorite(article: Article) {
		self.favoriteAstronomyArticles.insert(article, at: 0)
	}

	/// Delet Favorite from list swipe
	/// - Parameter offsets: offset permit to delet article with swipe gesture 
	func deletFavorite(at offsets: IndexSet) {
		favoriteAstronomyArticles.remove(atOffsets: offsets)
		save()
	}

	/// Delet selected article
	/// - Parameter article: Article is from NasaAstronomy model
	private func deletSelectedFavorite(article: Article) {
		self.favoriteAstronomyArticles.removeAll { $0.date == article.date }
	}

	/// Permit to move index of each article in the array manually.
	/// - Parameters:
	///   - index: From current position
	///   - offset: To final position
	func moveFavorite(from index: IndexSet, to offset: Int) {
		self.favoriteAstronomyArticles.move(fromOffsets: index, toOffset: offset)
		save()
	}

	/// Add or delet article if it's on array yet or no.
	/// - Parameter article: Picture, description and copyright.
	func addOrDeletFavorite(article: Article) {
		if self.favoriteAstronomyArticles.contains(article) {
			deletSelectedFavorite(article: article)
			save()
		} else {
			addToFavorite(article: article)
			save()
		}
	}
}
