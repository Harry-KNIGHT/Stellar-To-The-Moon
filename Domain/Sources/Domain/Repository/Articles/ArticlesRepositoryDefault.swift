//
//  ArticleRepositoryDefault.swift
//  
//
//  Created by Elliot Knight on 19/07/2023.
//

import Foundation
import Api

final public class ArticlesRepositoryDefault: ArticlesRepository {
	private let api: ArticlesService
	
	public init(api: ArticlesService) {
		self.api = api
	}

	public func getArticles() async throws -> [Article] {
		do {
			return try await api.getArticles()
		} catch {
			throw ArticleRepositoryErrors.cantFetchArticles
		}
	}
}

enum ArticleRepositoryErrors: Error {
	case cantFetchArticles
}
