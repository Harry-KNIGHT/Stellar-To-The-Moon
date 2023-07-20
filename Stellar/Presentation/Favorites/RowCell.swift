//
//  RowCell.swift
//  Stellar
//
//  Created by Elliot Knight on 30/08/2022.
//

import SwiftUI
import StellarMoonKit

// TODO: delet isInFavoriteListView bc it's used only on FavoritesListView.
struct RowCell: View {
	let article: Article

	var body: some View {
		HStack(alignment: .center, spacing: 10) {

			ArticleImageListCell(article: article, isInFavoriteListView: false)
				.frame(width: 90, height: 90)
				.cornerRadius(10)

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
		RowCell(article: .imageArticleSample)
			.previewLayout(.sizeThatFits)
		RowCell(article: .imageArticleSample)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
	}
}
