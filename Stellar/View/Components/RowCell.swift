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

	var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			Text(article.title)
				.font(.headline)
				.foregroundColor(.primary)
			Text(article.date)
				.font(.callout)
				.foregroundColor(.secondary)
			Text(article.explanation.trimmingCharacters(in: .whitespacesAndNewlines))
				.font(.body)
				.foregroundColor(.secondary)
				.lineLimit(2)
		}
		.multilineTextAlignment(.leading)
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
