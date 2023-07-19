//
//  RandomArticleRepositoryDefault.swift
//  
//
//  Created by Elliot Knight on 19/07/2023.
//

import Foundation
import StellarMoonKit

final class RandomArticleRepositoryDefault: RandomArticleRepository {
	func getRandomArticle() async throws -> Article {
		// TODO: Move from VM the logic for get these article

		return .imageArticleSample
	}
}
