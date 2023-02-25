//
//  ArticleDetailView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import UIKit
import ActivityIndicatorView
import StellarMoonKit

struct ArticleDetailView: View {
	public let article: Article
	@State private var isSheetPresented = false

	@EnvironmentObject var astronomyApi: ArticleDetailViewModel
	@State private var isImageDownloaded = false
	@State private var isImageDownloading = false

	var isShowingRandArticleGenration = false
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 0) {
				if article.mediaType == .image {
					ArticleImageView(article: article)
				} else {
					VideoView(videoID: article.url)
						.frame(minHeight: 450, maxHeight: 800)
						.accessibilityLabel("Video of the article")
				}
				
				if isShowingRandArticleGenration {
					GenerateRandomArticleButton()
						.padding(5)
				}
				VStack {
					HeadbandsDetailActions(
						article: article,
						isImageDowloaded: $isImageDownloaded,
						isDownloadingImage: $isImageDownloading
					)
					.padding(.top, 10)

					Text(article.explanation)
						.fontWeight(.medium)
						.multilineTextAlignment(.leading)
						.textSelection(.enabled)
						.accessibilityLabel(article.explanation)
						.padding()
				}
				.frame(maxWidth: .infinity)
				.background(.regularMaterial)
			}
		}
		.background(BackgroundImageCell(article: article))
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarTitle(article.title)
	}
}

struct ArticleDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ArticleDetailView(article: .articleSample)
				.environmentObject(ArticleDetailViewModel())
				.environmentObject(FavoriteViewModel())
		}
		NavigationView {
			ArticleDetailView(article: .articleSample, isShowingRandArticleGenration: true)
		}
	}
}
