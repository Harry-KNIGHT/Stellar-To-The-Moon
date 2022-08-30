//
//  FavoritesArticleList.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import SwiftUI

struct FavoritesArticleList: View {
	@EnvironmentObject public var favoriteVM: FavoriteViewModel
	var body: some View {
		NavigationView {
			VStack {
				if favoriteVM.favoriteAstronomyArticles.isEmpty {
					EmptyView()

				}else {
					List {
						ForEach(favoriteVM.favoriteAstronomyArticles, id: \.self) { article in
							NavigationLink(destination: AstronomyDetailView(article: article)) {
								RowCell(article: article)
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
			.navigationTitle("Favoris")
		}
	}
}

struct FavoritesArticleList_Previews: PreviewProvider {
	static var previews: some View {
		FavoritesArticleList()
			.environmentObject(FavoriteViewModel())
	}
}
