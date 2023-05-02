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
	var isShowingRandArticleGenration = false

	@State private var isSheetPresented = false

	@EnvironmentObject var astronomyApi: DownloadImageViewModel
	@State private var isImageDownloaded = false
	@State private var isImageDownloading = false

	// MARK: - Body

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 0) {
				switch article.mediaType {
				case .image:
					ArticleImageView(article: article)
				case .video:
					VideoView(videoID: article.mediaUrl)
						.frame(minHeight: 450, maxHeight: 800)
						.accessibilityLabel("Video of the article")
				}

				if isShowingRandArticleGenration {
					GenerateRandomArticleButton()
						.padding(5)
				}

				ArticleDetailBodyView(
					article: article,
					isImageDownloading: $isImageDownloading,
					isImageDownloaded: $isImageDownloaded
				)
				.padding(.horizontal)
				.padding(.bottom)
				.background(.regularMaterial)
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
			ArticleDetailView(article: .articleSample)
				.environmentObject(DownloadImageViewModel())
				.environmentObject(FavoriteViewModel())
		}
		NavigationView {
			ArticleDetailView(article: .articleSample, isShowingRandArticleGenration: true)
				.environmentObject(DownloadImageViewModel())
				.environmentObject(FavoriteViewModel())
				.environmentObject(SearchDateArticleViewModel())
		}
	}
}
