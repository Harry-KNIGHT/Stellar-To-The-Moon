//
//  ArticleRepositoryDefault.swift
//  
//
//  Created by Elliot Knight on 23/07/2023.
//

import Foundation
import StellarApi

public final class ArticleRepositoryDefault: ArticleRepository {
	private let api: ArticlesService

	public init(api: ArticlesService) {
		self.api = api
	}

	public func getArticles() async throws -> [Article] {
		do {
			let articles = try await api.getArticles()
			return articles.map { .init(dto: $0) }
		} catch {
			throw ArticleRepositoryError.noArticles
		}
	}
}

enum ArticleRepositoryError: Error {
	case noArticles
}
