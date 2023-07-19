//
//  RandomArticleRepository.swift
//  
//
//  Created by Elliot Knight on 19/07/2023.
//

import Foundation
import StellarMoonKit

protocol RandomArticleRepository {
	func getRandomArticle() async throws -> Article
}
