//
//  AstronomyImageView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import ActivityIndicatorView
import StellarMoonKit
import CachedAsyncImage

struct AstronomyImageView: View {
	let article: AstronomyArticleModel
	@EnvironmentObject var astronomyApi: AstronomyDetailViewModel

	@Environment(\.colorScheme) private var colorScheme

	@State private var isImageDowloaded: Bool = false
	@State private var isDownloadingImage = false

	@State private var isLoadingVisible = true
	@State private var showLoading = true
	@State private var circleProgress: CGFloat = 0.0

	@State private var animate = false
	var body: some View {
		CachedAsyncImage(url: URL(string: article.url), urlCache: .imageCache) { image in
			ZStack(alignment: .bottomTrailing) {
				ZStack(alignment: .bottomLeading) {
					image
						.resizable()
						.scaledToFill()
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
						.accessibilityLabel(article.title)

					if let copryRight = article.copyright {
						Text(copryRight)
							.modifier(CopyrightStyle())
					}
				}
				if !isImageDowloaded {
					DownloadImageButton(article: article, circleProgress: $circleProgress, isImageDowloaded: $isImageDowloaded, isDownloadingImage: $isDownloadingImage)
				} else {
					ImageDownloadedButton(animate: $animate)
				}
			}
		} placeholder: {
			LoadingArticleImagePlaceholder(isLoadingVisible: $isLoadingVisible)
		}
	}
}

struct AstronomyImageView_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyImageView(article: .astronomySample)
			.environmentObject(AstronomyDetailViewModel())
	}
}
