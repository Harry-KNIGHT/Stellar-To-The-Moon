//
//  ArticleImageView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import ActivityIndicatorView
import StellarMoonKit
import CachedAsyncImage

struct ArticleImageView: View {
	let article: Article
	@EnvironmentObject private var articleDetailVm: ArticleDetailViewModel
	
	@Environment(\.colorScheme) private var colorScheme
	
	@State private var isLoadingVisible = true
	
	@State private var animate = false
	var body: some View {
		CachedAsyncImage(url: URL(string: article.url), urlCache: .imageCache) { image in
			ZStack(alignment: .bottomLeading) {
				image
					.resizable()
					.scaledToFill()
					.frame(
						maxWidth: .infinity,
						maxHeight: .infinity,
						alignment: .top
					)
					.accessibilityLabel(article.title)
				
				if let copryRight = article.copyright {
					Text(copryRight)
						.copyrightStyle()
				}
			}
		} placeholder: {
			LoadingArticleImagePlaceholder(isLoadingVisible: $isLoadingVisible)
		}
	}
}

struct AstronomyImageView_Previews: PreviewProvider {
	static var previews: some View {
		ArticleImageView(article: .articleSample)
			.environmentObject(ArticleDetailViewModel())
	}
}
