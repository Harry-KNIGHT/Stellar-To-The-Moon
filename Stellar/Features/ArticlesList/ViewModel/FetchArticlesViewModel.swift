//
//  FetchArticlesViewModel.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import Domain

class FetchArticlesViewModel: ObservableObject {
	@Published var articles: [ArticlePresentation] = []
	private let repository: ArticleRepository


	init(repository: ArticleRepository) {
		self.repository = repository

		Task {
			await getArticles()
		}
	}

	@MainActor
	private func getArticles() async {
		Task {
			do {
				let fetchedArticles = try await repository.getArticles()

				articles = fetchedArticles.map {
					ArticlePresentation(
						title: $0.title,
						copyright: $0.copyright,
						explanation: $0.explanation,
						date: $0.date,
						mediaUrl: $0.mediaUrl,
						isFavorite: false
					)
				}
			} catch {
				throw ViewModelErrors.emptyDataReceived
			}
		}
	}
}

enum ViewModelErrors: Error {
	case emptyDataReceived
}
