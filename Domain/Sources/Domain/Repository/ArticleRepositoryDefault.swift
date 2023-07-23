//
//  ArticleRepositoryDefault.swift
//  
//
//  Created by Elliot Knight on 23/07/2023.
//

import Foundation
import StellarApi

class ArticleRepositoryDefault: ArticleRepository {
	func getArticles() async throws -> [Article] {
		do {
			let articles = try await SellerService.getArticles()
			return articles.map { Article(dto: articles) }
		} catch {
			throw ArticleRepositoryError.noArticles
		}
	}
}

enum ArticleRepositoryError: Error {
	case noArticles
}
