//
//  AddFavoriteButtonCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI
import StellarMoonKit

struct AddFavoriteButtonCell: View {
	let article: Article
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	
	var body: some View {
		Button(action: {
			favoriteVM.addOrDeletFavorite(article: article)
		}, label: {
			Image(systemName: favoriteVM.favoriteAstronomyArticles.contains(article) ? "star.fill" : "star")
				.navigationButtonLabelStyle(.title)
		})
		.accessibilityLabel("Add this article to favorites")
	}
}

struct AddFavoriteButtonCell_Previews: PreviewProvider {
	static var previews: some View {
		AddFavoriteButtonCell(article: .articleSample)
			.environmentObject(FavoriteViewModel())
	}
}
