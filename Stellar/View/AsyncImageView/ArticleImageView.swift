//
//  ArticleImageView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import StellarMoonKit
import CachedAsyncImage
import UIKit

struct ArticleImageView: View {
	let article: Article
	@EnvironmentObject private var articleDetailVm: DownloadImageViewModel
	
	@Environment(\.colorScheme) private var colorScheme
	
	@State private var isLoadingVisible = true

	@State private var animate = false
	var body: some View {
		CachedAsyncImage(url: URL(string: article.mediaUrl), urlCache: .imageCache) { image in
			image
				.resizable()
				.aspectRatio(contentMode: .fill)
				.addPinchZoom()
				.frame(
					maxWidth: getRect().width,
					maxHeight: getRect().height
				)
				.accessibilityLabel(article.title)
		} placeholder: {
			LoadingArticleImagePlaceholder(isLoadingVisible: $isLoadingVisible)
		}
	}
}

struct AstronomyImageView_Previews: PreviewProvider {
	static var previews: some View {
		ArticleImageView(article: .articleSample)
			.environmentObject(DownloadImageViewModel())
	}
}
