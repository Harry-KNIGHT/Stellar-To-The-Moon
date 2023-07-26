//
//  ArticleRepository.swift
//  
//
//  Created by Elliot Knight on 23/07/2023.
//

import Foundation

public protocol ArticleRepository {
	func getArticles() async throws -> [Article]
}
