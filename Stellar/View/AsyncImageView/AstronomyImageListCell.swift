//
//  AstronomyImageListCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI
import StellarMoonKit
struct AstronomyImageListCell: View {
	let article: AstronomyArticleModel
	let size = (deviceWidth / 2)

	var body: some View {
		AsyncImage(url: URL(string: article.url)) { image in
			ZStack(alignment: .bottomLeading) {
				image
					.resizable()
					.frame(maxWidth: size, maxHeight: size)
					.cornerRadius(0)
					.accessibilityLabel("Image of \(article.title)")
				Text(article.title)
					.lineLimit(1)
					.foregroundStyle(.white)
					.background(.black.opacity(0.8))
			}
			.background(.red)

		} placeholder: {
			ZStack {
				RoundedRectangle(cornerRadius: 0)
					.frame(maxWidth: size, minHeight: size)
					.foregroundStyle(.secondary)
				ProgressView()
					.foregroundStyle(.primary)
			}
			.accessibilityLabel("Image loading placeholder")
		}
	}
}

struct AstronomyImageListCell_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyImageListCell(article: .astronomySample)
	}
}

public var deviceWidth: CGFloat {
	UIScreen.main.bounds.width
}
