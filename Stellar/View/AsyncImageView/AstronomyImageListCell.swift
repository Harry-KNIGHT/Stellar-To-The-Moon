//
//  AstronomyImageListCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI
import StellarMoonKit
import CachedAsyncImage

struct AstronomyImageListCell: View {
	let article: AstronomyArticleModel
	let size = (deviceWidth / 2)
	var isInFavoriteListView: Bool

	var body: some View {
		CachedAsyncImage(url: URL(string: article.url), urlCache: .imageCache) { image in
			ZStack(alignment: .bottomLeading) {
				image
					.resizable()
					.frame(maxWidth: size, maxHeight: size)
					.cornerRadius(0)
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
		} placeholder: {
			ZStack {
				RoundedRectangle(cornerRadius: 0)
					.frame(maxWidth: size, minHeight: size)
					.foregroundStyle(.secondary)
				ProgressView()
					.foregroundStyle(.primary)
			}
			.border(.black)
			.accessibilityLabel("Image loading placeholder")
		}
	}
}

struct AstronomyImageListCell_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyImageListCell(article: .astronomySample, isInFavoriteListView: false)
	}
}

public var deviceWidth: CGFloat {
	UIScreen.main.bounds.width
}
