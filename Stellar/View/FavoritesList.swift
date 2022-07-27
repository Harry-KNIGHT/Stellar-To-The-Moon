//
//  FavoritesList.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import SwiftUI

struct FavoritesList: View {
	@EnvironmentObject public var favoriteVM: FavoriteViewModel
	var body: some View {
		NavigationView {
			List {
				ForEach(favoriteVM.favoriteAstronomyArticles, id: \.self) { article in
					NavigationLink(destination: AstronomyDetailView(astronomyObject: article)) {
						ListRowCell(title: article.title, date: article.date, explanation: article.explanation)
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
}

struct FavoritesList_Previews: PreviewProvider {
	static var previews: some View {
		FavoritesList()
			.environmentObject(FavoriteViewModel())
	}
}
