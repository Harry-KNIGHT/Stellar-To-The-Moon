//
//  FavoritesArticlesView.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import SwiftUI

struct FavoritesArticlesView: View {
	@EnvironmentObject private var favoriteVM: FavoriteViewModel
	var body: some View {
		NavigationView {
			VStack {
				if favoriteVM.favoriteArticles.isEmpty {
					EmptyView()
				} else {
					FavoritesListView()
				}
			}
			.navigationTitle("Favorites")
		}
	}
}

struct FavoritesArticlesView_Previews: PreviewProvider {
	static var previews: some View {
		FavoritesArticlesView()
			.environmentObject(FavoriteViewModel())
			.environmentObject(ArticleViewModel())
	}
}

