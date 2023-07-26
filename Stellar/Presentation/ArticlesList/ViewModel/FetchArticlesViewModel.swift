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

	@MainActor
	private func getArticles() async {
		Task {
			do {
				let fetchedArticles = try await repository.getArticles()
				articles = fetchedArticles
			} catch {
				throw ViewModelErrors.emptyDataReceived
			}
		}
	}
}

enum ViewModelErrors: Error {
	case emptyDataReceived
}
