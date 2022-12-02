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
	let astronomy: AstronomyArticleModel
	@EnvironmentObject var astronomyApi: AstronomyDetailViewModel

	@Environment(\.colorScheme) private var colorScheme

	@State private var isImageDowloaded: Bool = false
	@State private var isDownloadingImage = false

	@State private var isLoadingVisible = true
	@State private var showLoading = true
	@State private var circleProgress: CGFloat = 0.0

	@State private var animate = false
	var body: some View {
		CachedAsyncImage(url: URL(string: astronomy.url), urlCache: .imageCache) { image in
			ZStack(alignment: .bottomTrailing) {
				ZStack(alignment: .bottomLeading) {
					image
						.resizable()
						.scaledToFill()
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
						.accessibilityLabel(astronomy.title)

					if let copryRight = astronomy.copyright {
						Text(copryRight)
							.modifier(CopyrightStyle())
					}
				}
				if !isImageDowloaded {
					DownloadImageButton(article: astronomy, circleProgress: $circleProgress, isImageDowloaded: $isImageDowloaded, isDownloadingImage: $isDownloadingImage)
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
		AstronomyImageView(astronomy: .astronomySample)
			.environmentObject(AstronomyDetailViewModel())
	}
}

struct LoadingArticleImagePlaceholder: View {
	@Binding var isLoadingVisible: Bool
	var body: some View {
		ZStack {
			Rectangle()
				.frame(minHeight: 200, maxHeight: 350)
				.foregroundStyle(.regularMaterial)

			ActivityIndicatorView(isVisible: $isLoadingVisible, type: .equalizer(count: 10))
				.frame(width: 100, height: 50)
				.foregroundColor(.primary)
				.accessibilityLabel("Loading image")
		}
	}
}
