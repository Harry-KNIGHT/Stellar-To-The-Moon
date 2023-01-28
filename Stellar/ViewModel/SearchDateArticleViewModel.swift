//
//  SearchDateArticleViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/01/2023.
//

import SwiftUI
import StellarMoonKit

class SearchDateArticleViewModel: ObservableObject {
	@Published var article: AstronomyArticleModel?

	@MainActor
	func searchOneArticle(date: Date)  {
		Task {
			do {
				article = try await SearchSingleArticleApi.searchOneArticle(date: date)
			} catch {
				DispatchQueue.main.async {
					print(error)
				}
			}
		}
	}

	
}
