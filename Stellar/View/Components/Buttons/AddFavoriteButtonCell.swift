//
//  AddFavoriteButtonCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI
import StellarMoonKit

struct AddFavoriteButtonCell: View {
	let article: AstronomyArticleModel
	@EnvironmentObject var favoriteVM: FavoriteViewModel

    var body: some View {
		Button(action: {
			favoriteVM.addOrDeletFavorite(article: article)
		}, label: {
			Label("Add article to favorite", systemImage: favoriteVM.favoriteAstronomyArticles.contains(article) ? "star.fill" : "star")
				.navigationButtonLabelStyle()
		})
		.accessibilityLabel("Add this article to favorites")
    }
}

struct AddFavoriteButtonCell_Previews: PreviewProvider {
    static var previews: some View {
		AddFavoriteButtonCell(article: .astronomySample)
			.environmentObject(FavoriteViewModel())
    }
}
