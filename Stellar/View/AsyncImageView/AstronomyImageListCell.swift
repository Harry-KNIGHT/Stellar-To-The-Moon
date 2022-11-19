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
	let size: CGFloat = 90
    var body: some View {
		AsyncImage(url: URL(string: article.url)) { image in
			image
				.resizable()
				.frame(maxWidth: size, maxHeight: size)
				.cornerRadius(10)
				.accessibilityLabel("Image of \(article.title)")

		} placeholder: {
			ZStack {
				RoundedRectangle(cornerRadius: 10)
					.frame(width: size, height: size)
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
