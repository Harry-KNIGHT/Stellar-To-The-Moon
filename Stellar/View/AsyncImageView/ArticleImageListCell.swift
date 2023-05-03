//
//  ArticleImageListCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI
import StellarMoonKit
import CachedAsyncImage

struct ArticleImageListCell: View {
	let article: Article

	var isInFavoriteListView: Bool

	var body: some View {
		CachedAsyncImage(url: URL(string: article.mediaUrl), urlCache: .imageCache) { image in
			ZStack(alignment: .bottomLeading) {
				image
					.resizable()
					.accessibilityLabel("Image of \(article.title)")
			}
			.border(isInFavoriteListView ? .clear : .black)
			.frame(maxWidth: deviceSizeDivisedByTwo, maxHeight: deviceSizeDivisedByTwo)
		} placeholder: {
			ZStack {
				RoundedRectangle(cornerRadius: 0)
					.frame(maxWidth: deviceSizeDivisedByTwo, minHeight: deviceSizeDivisedByTwo)
					.foregroundStyle(.secondary)
				ProgressView()
					.foregroundStyle(.primary)
			}
			.border(.black)
			.accessibilityLabel("Image loading placeholder")
		}
	}
}

struct ArticleImageListCell_Previews: PreviewProvider {
	static var previews: some View {
		ArticleImageListCell(article: .imageArticleSample, isInFavoriteListView: false)
			.previewLayout(.sizeThatFits)
	}
}
