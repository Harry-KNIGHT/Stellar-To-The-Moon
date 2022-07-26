//
//  FavoriteViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import Foundation
import StellarMoonKit

class FavoriteViewModel: ObservableObject {
	@Published var favoriteAstronomyArticles: [AstronomyArticleModel]

	init() {
		if let data = UserDefaults.standard.data(forKey: "SavedFavoritesData") {
			if let decoded = try? JSONDecoder().decode([AstronomyArticleModel].self, from: data) {
				favoriteAstronomyArticles = decoded
				return
			}
		}
		// No Saved data
		favoriteAstronomyArticles = []
	}

	func save() {
		if let encoded = try? JSONEncoder().encode(favoriteAstronomyArticles) {
			UserDefaults.standard.set(encoded, forKey: "SavedFavoritesData")
		}
	}

	/// Add article to favorite
	/// - Parameter article: Article is from NasaAstronomy model
	func addToFavorite(article: AstronomyArticleModel) {
		self.favoriteAstronomyArticles.append(article)
	}

	/// Delet Favorite from list swipe
	/// - Parameter offsets: offset permit to delet article with swipe gesture 
	func deletFavorite(at offsets: IndexSet) {
		favoriteAstronomyArticles.remove(atOffsets: offsets)
		save()
	}

	/// Delet selected article
	/// - Parameter article: Article is from NasaAstronomy model
	func deletSelectedFavorite(article: AstronomyArticleModel) {
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
	func addOrDeletFavorite(article: AstronomyArticleModel) {
		if self.favoriteAstronomyArticles.contains(article) {
			deletSelectedFavorite(article: article)
			save()
		} else {
			addToFavorite(article: article)
			save()
		}
	}
}
