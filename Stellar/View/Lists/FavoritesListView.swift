//
//  FavoritesListView.swift
//  Stellar
//
//  Created by Elliot Knight on 30/11/2022.
//

import SwiftUI

struct FavoritesListView: View {
	@EnvironmentObject public var favoriteVM: FavoriteViewModel

	var body: some View {
		List {
			ForEach(favoriteVM.favoriteAstronomyArticles, id: \.date) { article in
				NavigationLink(destination: AstronomyDetailView(article: article)) {
					RowCell(article: article, isInFavoriteListView: true)
				}
			}
			.onDelete(perform: favoriteVM.deletFavorite)
			.onMove(perform: favoriteVM.moveFavorite)
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				EditButton()
			}
		}
	}
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
			.environmentObject(FavoriteViewModel())
    }
}
