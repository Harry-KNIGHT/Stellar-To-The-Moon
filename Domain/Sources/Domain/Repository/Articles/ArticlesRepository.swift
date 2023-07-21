//
//  ArticlesRepository.swift
//  
//
//  Created by Elliot Knight on 19/07/2023.
//

import Foundation
import Api

public protocol ArticlesRepository {
	func getArticles() async throws -> [Article]
}
