//
//  SearchDateArticleViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/01/2023.
//

import SwiftUI
@preconcurrency import StellarMoonKit

class SearchDateArticleViewModel: ObservableObject {
	@Published var article: Article?

	@MainActor
	func generateOneArticle()  {
		Task {
			do {
				article = try await GenerateRandomArticleApi.generateOneArticle()
			} catch {
				DispatchQueue.main.async {
					print(error)
				}
			}
		}
	}
}
