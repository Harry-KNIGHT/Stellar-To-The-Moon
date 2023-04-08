//
//  ArticlesGridView.swift
//  Stellar
//
//  Created by Elliot Knight on 30/11/2022.
//

import SwiftUI

struct ArticlesGridView: View {
	@EnvironmentObject var articleVm: ArticleViewModel

	private let columnsiPhone = [
		GridItem(.flexible(), spacing: 0),
		GridItem(.flexible(), spacing: 0)
	]
	private let columnsiPad = [
		GridItem(.flexible(), spacing: 0),
	]
	private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

	@Binding var showFavoritesSheet: Bool
	@Binding var showBirthdayPicker: Bool

	var body: some View {
		ScrollView {
			LazyVGrid(columns: idiom == .phone ? columnsiPhone : columnsiPad, alignment: .center, spacing: 0) {
				ForEach(articleVm.articles.reversed(), id: \.date) { article in
					NavigationLink(destination: ArticleDetailView(article: article, isInFavoriteDetail: false)) {
						if article.mediaType == .image {
							ArticleImageListCell(article: article, isInFavoriteListView: false)
						} else {
							VideoPlaceHolderCell(article: article)
						}
					}
				}
			}
		}
		.toolbar {
			ToolbarItemGroup(placement: .navigationBarTrailing) {
				ShowRandomArticleView(showBirthdayPicker: $showBirthdayPicker)

				if !articleVm.articles.isEmpty.self {
					ShowFavSheetButtonCell(showFavoritesSheet: $showFavoritesSheet)
				}
			}
		}
	}
}


struct ArticlesGridView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ArticlesGridView(
				showFavoritesSheet: .constant(false),
				showBirthdayPicker: .constant(false)
			)
			.environmentObject(ArticleViewModel())
		}
	}
}
