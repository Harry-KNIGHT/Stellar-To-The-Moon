//
//  SearchDateFetchArticlesViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/01/2023.
//

import SwiftUI
@preconcurrency import StellarMoonKit

class SearchDateArticleViewModel: ObservableObject {
	@Published var article: Article?

	@MainActor
	func generateOneArticle() {
		Task {
			do {
				let fetchedArticle = try await GenerateRandomArticleApi.generateOneArticle()
				fetchAgainIfArticleMediaTypeIsVideo(fetchedArticle: fetchedArticle)

			} catch {
				DispatchQueue.main.async {
					print(error)
				}
			}
		}
	}

	@MainActor
	private func fetchAgainIfArticleMediaTypeIsVideo(fetchedArticle: Article) {
		Task {
			switch fetchedArticle.mediaType {
			case .video:
				generateOneArticle()
			case .image:
				article = fetchedArticle
			}
		}
	}
}
