//
//  RowCell.swift
//  Stellar
//
//  Created by Elliot Knight on 30/08/2022.
//

import SwiftUI
import StellarMoonKit

struct RowCell: View {
	let article: AstronomyArticleModel
	let size: CGFloat = 90
	var body: some View {
		HStack(alignment: .center, spacing: 10) {
			if article.mediaType == .image {
				AstronomyImageListCell(article: article)
			} else {
				VideoPlaceHolderCell(article: article)
			}
			VStack(alignment: .leading, spacing: 3) {
				Text(article.title)
					.font(.body)
					.fontWeight(.semibold)
					.foregroundColor(.primary)
					.lineLimit(1)
					.accessibilityLabel(article.title)
				Text(article.date)
					.font(.callout)
					.foregroundColor(.secondary)
				Text(article.explanation.trimmingCharacters(in: .whitespacesAndNewlines))
					.font(.body)
					.foregroundColor(.secondary)
					.lineLimit(2)
					.accessibilityHidden(true)
			}
			.multilineTextAlignment(.leading)
			Spacer()
		}
	}
}

struct RowCell_Previews: PreviewProvider {
	static var previews: some View {
		RowCell(article: .astronomySample)
			.previewLayout(.sizeThatFits)
		RowCell(article: .astronomySample)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
	}
}
