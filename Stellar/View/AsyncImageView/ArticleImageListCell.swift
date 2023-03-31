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
		CachedAsyncImage(url: URL(string: article.url), urlCache: .imageCache) { image in
			ZStack(alignment: .bottomLeading) {
				image
					.resizable()
					.accessibilityLabel("Image of \(article.title)")
				if !isInFavoriteListView {
					HStack {
						Text(article.title)
							.lineLimit(1)
							.foregroundStyle(.white)
							.padding(.leading, 4)
						Spacer()
					}
					.padding(.top, 2)
					.background(.linearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .center))
				}
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
		ArticleImageListCell(article: .articleSample, isInFavoriteListView: false)
			.previewLayout(.sizeThatFits)
	}
}
