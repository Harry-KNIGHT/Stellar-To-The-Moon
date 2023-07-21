//
//  ArticleDetailPhotoView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import Api
import CachedAsyncImage
import UIKit

struct ArticleDetailPhotoView: View {
	let article: Article
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
			ZStack {
				Rectangle()
					.frame(minHeight: 200, maxHeight: 350)
					.foregroundStyle(.regularMaterial)

				ProgressView()
					.frame(width: 100, height: 50)
					.foregroundColor(.primary)
					.accessibilityLabel("Loading image")
			}
		}
	}
}

struct ArticleDetailPhotoView_Previews: PreviewProvider {
	static var previews: some View {
		ArticleDetailPhotoView(article: .imageArticleSample)
	}
}
