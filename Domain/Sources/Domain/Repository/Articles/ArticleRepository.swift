//
//  File.swift
//  
//
//  Created by Elliot Knight on 19/07/2023.
//

import Foundation
import StellarMoonKit

protocol ArticleRepository {
	func getArticles() async throws -> [Article]
}
