//
//  FetchDeeplinkArticleViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 11/04/2023.
//

import Foundation
import StellarMoonKit

class FetchDeeplinkArticleViewModel: ObservableObject {
	@Published public var deeplinkArticle: Article?

	func fetchRemoteDeeplinkArticle(_ date: String) {
		Task {
			deeplinkArticle = try await FetchDeeplinkArticle.fetchDeeplinkArticle(date: date)
		}
	}
}
