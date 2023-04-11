//
//  ArticleDetailView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import StellarMoonKit
import UIKit

struct ArticleDetailView: View {
	public let article: Article

	// MARK: Properties
	var isOnRandomArticleGeneration = false

	@State private var isSheetPresented = false

	@EnvironmentObject var astronomyApi: DownloadImageViewModel
	@State private var isImageDownloaded = false
	@State private var isImageDownloading = false

	// MARK: - Body

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 0) {
				ArticleImageView(article: article)

				ArticleDetailBodyView(
					article: article,
					isOnRandomArticleGeneration: isOnRandomArticleGeneration,

					isImageDownloading: $isImageDownloading,
					isImageDownloaded: $isImageDownloaded
				)
				.padding(.horizontal)
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarTitle(article.title)
	}
}

// MARK: - Preview

struct ArticleDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ArticleDetailView(article: .imageArticleSample)
				.environmentObject(DownloadImageViewModel())
				.environmentObject(FavoriteViewModel())
		}
		NavigationView {
			ArticleDetailView(article: .imageArticleSample, isOnRandomArticleGeneration: true)
				.environmentObject(DownloadImageViewModel())
				.environmentObject(FavoriteViewModel())
				.environmentObject(SearchDateArticleViewModel())
		}
	}
}
