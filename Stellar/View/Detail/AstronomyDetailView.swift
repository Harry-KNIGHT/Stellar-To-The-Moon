//
//  AstronomyDetailView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import UIKit
import ActivityIndicatorView
import StellarMoonKit

struct AstronomyDetailView: View {
	public let article: AstronomyArticleModel
	@State private var isSheetPresented = false

	@EnvironmentObject var astronomyApi: AstronomyDetailViewModel
	var isShowingRandArticleGenration = false
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			if article.mediaType == .image {
				AstronomyImageView(article: article)
			} else {
				VideoView(videoID: article.url)
					.frame(minHeight: 450, maxHeight: 800)
					.accessibilityLabel("Video of the article")
			}

			if isShowingRandArticleGenration {
				GenerateRandomArticleButton()
					.padding(.horizontal, 10)
			}

			Text(article.explanation)
				.fontWeight(.medium)
				.multilineTextAlignment(.leading)
				.textSelection(.enabled)
				.accessibilityLabel(article.explanation)
				.padding()
				.background(.regularMaterial)
		}
		.background(BackgroundImageCell(article: article))
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarTitle(article.title)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				AddFavoriteButtonCell(article: article)
			}
		}
	}
}

struct AstronomyDetailView_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyDetailView(article: .astronomySample)
			.environmentObject(AstronomyDetailViewModel())
			.environmentObject(FavoriteViewModel())
		AstronomyDetailView(article: .astronomySample, isShowingRandArticleGenration: true)
	}
}
