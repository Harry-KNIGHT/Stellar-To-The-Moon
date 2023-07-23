//
//  FavoritesListView.swift
//  Stellar
//
//  Created by Elliot Knight on 30/11/2022.
//

import SwiftUI

struct FavoritesListView: View {
	@EnvironmentObject private var favoriteVM: FavoriteViewModel

	var body: some View {
		if favoriteVM.favoriteArticles.isEmpty {
			EmptyView()
		} else {
			List {
//				ForEach(favoriteVM.favoriteArticles) { article in
//					NavigationLink(destination: ArticleDetailView(article: article)) {
//						ListRowCell(article: article)
//					}
//				}
//				.onDelete(perform: favoriteVM.deletFavorite)
//				.onMove(perform: favoriteVM.moveFavorite)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
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
