//
//  FavoriteViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import Foundation

class FavoriteViewModel: ObservableObject {
	@Published public var favoriteAstronomyArticles = [NasaAstronomyResponse]()

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
		}else {
			addToFavorite(article: article)
		}
	}
}
